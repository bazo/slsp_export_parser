#!/usr/bin/perl

use strict;
use warnings;

binmode(STDOUT, ":utf8");

print "Starting...\n";

open(FILE, "< vypis.txt");



foreach my $line (<FILE>) {
	chomp($line);
	#($date,$x2,$x3,$x4,$x5,$x6,$x7,$amount) = split(/;/,$line);
	my @d = split(/;/,$line);
	print 	"         Datum: $d[0]\n".
		"          Suma: $d[7] $d[8]\n".
		"            Od: $d[4]/$d[5] $d[6]\n".
		"           Typ: $d[11]\n".
		"          Info: $d[12] $d[16] $d[18] $d[22]\n\n";
}

print "Done\n";
