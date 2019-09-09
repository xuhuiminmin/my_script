#!perl -w
open (IN,$ARGV[0]) or die "";
   while (<IN>){
   chomp;
   @line =split(/\s+/,$_);
   $line[0] =~ /(PB.\d+).\d+/;
   $a = $1;
   print "$a\n";
}
close IN;
