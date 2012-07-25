#!/usr/bin/perl

use strict;
use warnings;

binmode(STDOUT, ":utf8");

print "Starting...\n";

open(FILE, "< vypis.txt");

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

foreach my $line (<FILE>) {
	chomp($line);
	my @d = split(/;/,$line);
	print 	"         Datum: $d[0]\n".
		"          Suma: $d[7] $d[8]\n".
		"            Od: $d[4]/$d[5] $d[6]\n".
		"           Typ: $d[11]\n".
		"          Info: $d[12] $d[16] $d[18] $d[22]\n\n";
}

print "Done\n";
