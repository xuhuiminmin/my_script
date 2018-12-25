#!perl -w
open(IN,$ARGV[0]) or die "";
<IN>;
print "Term\tGene_number\tFDR\tRich_Factor\n";
while(<IN>){
     chomp;
     @data = split(/\t/,$_);
     $rich = $data[3]/$data[4];
     $fdr = sprintf"%e",$data[5]; #or data[6] 
 #    if($fdr < 0.75){
     print "$data[0]\t$data[3]\t$fdr\t$rich\n";
#}
}
close IN;
