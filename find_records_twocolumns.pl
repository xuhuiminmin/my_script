#!perl -w
use Getopt::Std;
getopts "l:d:o:";

$list = $opt_l;
$database = $opt_d;
$output = $opt_o;

if ((!defined $opt_l)|| (!defined $opt_d) || (!defined $opt_o) ) {
        die "************************************************************************
        Usage: perl find_records_twocolumns.pl -l listfile -d database -o output
          -h : help and usage.
          -l : gene list. Note the the name of gene should be same with the database
          -d : database records file
          -o : output
************************************************************************\n";
}
my %genedb;
open(IN, $database) or die"";
while(<IN>){
          chomp;
          @data = split(/\t/,$_);
          $name = $data[0];
          $exon = $data[1];
          $genedb{$name} = $exon;

}
close IN;
open(OUT, ">$output") or die"";
open(IN, $list) or die"";
while(<IN>){
          chomp;
          @line = split(/\s+/,$_);
          $line1 = $line[0];
          $line1 =~ s/s+.*//g;
if (exists ($genedb{$line1})){
print OUT "$genedb{$line1}\n";
}else{print OUT "\n";}
}
close IN;
close OUT;
