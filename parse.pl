#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use DBD::mysql;
use Time::Local;

my $dbh;
my $prog = "slsp_parser";

binmode(STDOUT, ":utf8");

print "Starting...\n";

sub db_reconnect {
	print "(re)connecting DB\n";
	$dbh->disconnect if $dbh;
	my $dsn = "DBI:mysql:slsp:localhost";
	$dbh = DBI->connect($dsn,'slsp','slsp')
			or die "$prog FAIL: Unable to connect: $dbh->errstr";
	$dbh->ping or die "$prog FAIL: Unable to verify open database: $dbh->errstr";
}

db_reconnect();

my @files = <data/*>;

#datove pole obsahuje:
#
#  0 - uctovny datum
#  1 - ?
#  2 - moje cislo uctu
#  3 - ?
#  4 - odkial, alebo kam peniaze prisli/odisli
#  5 - cislo banky k uctu v poli 3
#  6 - poznamka spracovatela platby
#  7 - suma
#  8 - mena
#  9 - ?
# 10 - zostatok na ucte
# 11 - typ tranzakcie
# 12 - variabilny symbol
# 13 - specificky symbol
# 14 - ?
# 15 - ?
# 16 - popis tranzakcie (asi len automatizovane vlozeny)
# 17 - ?
# 18 - poznamka od odosielatela (ked nieco pride, takze niekoho poznamka)
# 19,20,21 - ?
# 22 - poznamka od odosielatela (ked ja som odosielatelom - takze moja)


foreach my $file (@files) {
	open(FILE, "< $file");
	foreach my $line (<FILE>) {
		chomp($line);
		my @d = split(/;/,$line);
		#parse date string to unix timestamp
		my @t = $d[0] =~ m!(\d{2})\.(\d{2})\.(\d{4})!;
		$t[1]--;
		print $t[0]."\n";
		my $timestamp = timelocal 0,0,12,@t[0,1,2];
		print 	"         Datum: $d[0] ($timestamp)\n".
			"          Suma: $d[7] $d[8]\n".
			"            Od: $d[4]/$d[5] $d[6]\n".
			"           Typ: $d[11]\n".
			"          Info: $d[12] $d[16] $d[18] $d[22]\n\n";
		my $sth = $dbh->prepare("INSERT INTO `transactions` (`date`,`amount`, `info`) VALUES (?,?,?)")
			or print "$prog FAIL: mysql prepare failed: $dbh->errstr\n";
		$sth->execute($timestamp,$d[7],$d[4]."/".$d[5]." ".$d[6]." ".$d[12]." ".$d[16]." ".$d[18]." ".$d[22]) or print "$prog FAIL: mysql exec failed: $dbh->errstr\n";
	}
}

print "Done\n";
