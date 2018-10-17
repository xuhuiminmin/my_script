#!perl -w
####usage:perl $0 gene.position.gff gene.fasta > output


my %hash;
open(IN,$ARGV[0]) or die "";
while(<IN>){
     @line = split(/\s+/,$_);
     $id = $line[3];
     $hash{$id} = $_; 
}
close IN;
print "Chr\tstart\tend\tgeneid\tstrand\tthree_prime_UTR_start\tend\tfive_prime_UTR_start\tend\n";
open(IM,$ARGV[1]) or die"";
$/='>';
<IM>;
while(<IM>){
     my($name,$seq) = split(/\n/,$_,2);
     if(exists ($hash{$name})){
     $gff = $hash{$name};
     @data = split(/\s+/,$gff);
     $chr = $data[0];
     $dire = $data[4];
     $ex1_start = $data[1];
     $ex_end = $data[2];
     $star_pos = index($seq,"ATG");
     $stop_pos1 = rindex($seq,"TAA");
     $stop_pos2 = rindex($seq,"TGA");
     $stop_pos3 = rindex($seq,"TAG");
     my @arry = ($stop_pos1,$stop_pos2,$stop_pos3);
     @arry = sort{$a <=> $b} @arry;
     $stop_pos = $arry[-1];
     $th_utr1 = $ex1_start;
     $th_utr2 = $ex1_start + $star_pos-2; 
     $fi_utr1 = $ex1_start + $stop_pos+2;
     $fi_utr2 = $ex_end;
     print "$chr\t$ex1_start\t$ex_end\t$name\t$dire\t$th_utr1\t$th_utr2\t$fi_utr1\t$fi_utr2\n";
     }
}
close IM;
