#!perl -w
open(IN,$ARGV[0]) or die "";
$/='>';
<IN>;
while(<IN>){
     chomp;
     my($name,$seq)= split(/\n/,$_,2);
     $seq =~ s/\s.*//g;
     $len = length$seq; 
     print "$len\n";   
}
close IN;
