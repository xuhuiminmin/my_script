#!perl -w
use Getopt::Std;
getopts "l:d:o:";

$list = $opt_l;
$database = $opt_d;
#!perl -w
use Getopt::Std;
getopts "l:d:o:";

$list = $opt_l;
$database = $opt_d;
$output = $opt_o;

if ((!defined $opt_l)|| (!defined $opt_d) || (!defined $opt_o) ) {
        die "************************************************************************
        Usage: perl getRecordFromList.pl -l listfile -d database -o output
          -h : help and usage.
          -l : gene list. Note the the name of gene should be same with the database
          -d : database record file
          -o : output
************************************************************************\n";
}

open (IN,$database) or die "";
open (OUT,">$output");
my %recorddb;
$fi= <IN>;
print OUT "$fi";
while(<IN>){
          chomp;
          @data = split(/\s+/,$_);
          $name = shift@data;
          $num = join("\t",@data);
          $recorddb{$name} = $num;

#print "$name\n";
}
close IN;
open (IM,$list) or die"";
while(<IM>){
           chomp;
           @tmp = split (/\s+/,$_);
          $line = $tmp[0];
     if (exists ($recorddb{$line})){
    print OUT "$line\t$recorddb{$line}\n";
}else{print OUT "$line\tNA\tNA\tNA\tNA\tNA\n";}
}
close IM;
close OUT;
