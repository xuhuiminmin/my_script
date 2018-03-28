#!/usr/bin/perl  -w
open(IN, $ARGV[0]) or die "";
$/='>';
<IN>;
while (<IN>){
	chomp;
	my ($name,$seq) = split (/\n/,$_,2);
	$name =~ s/\s+.*//g;
	$seq  =~ s/\s+//g;
	print ">$name\n$seq\n";
	}
	close IN;
#######################################################################################################
#######################################################################################################
#!perl -w
open(IN,$ARGV[0]) or die"";
open(OUT,">$ARGV[1]");
while(<IN>){
           chomp;
           @line = split(/\s+/,$_);
           $name = $line[0].".1";
           print OUT "$name\n$line[1]";



}
close IN;
close OUT;
