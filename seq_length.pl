#!perl -w
open(IN,$ARGV[0]) or die "";
$/='>';
<IN>;
while(<IN>){
     chomp;
     my($name,$seq)= split(/\n/,$_,2);
     $len = length$seq; 
     print "$len\n";   
}
close IN;
