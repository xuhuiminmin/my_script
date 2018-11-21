#!perl -w
#####perl utr.pl transcript_pos.gff collaped.collapsed.rep.fa > utr_position.txt
my %hash;
open(IN,$ARGV[0]) or die "";
while(<IN>){
     @line = split(/\s+/,$_);
     $id = $line[11];
     $id =~ s/\"//g;
     $id =~ s/\;//g;
     $hash{$id} = $_; 
}
close IN;
print "Chr\tstart\tend\tgeneid\tstrand\tfive_prime_UTR_start\tend\tthree_prime_UTR_start\tend\n";
open(IM,$ARGV[1]) or die"";
$/='>';
<IM>;
while(<IM>){
     my($name,$seq) = split(/\n/,$_,2);
     $name =~ s/\|.*//g;
     if(exists ($hash{$name})){
     $gff = $hash{$name};
     @data = split(/\s+/,$gff);
     $chr = $data[0];
     $dire = $data[6];
     $ex1_start = $data[3];
     $ex_end = $data[4];
     if($dire eq '+'){
     $star_pos = index($seq,"ATG");
     $stop_pos1 = rindex($seq,"TAA");
     $stop_pos2 = rindex($seq,"TGA");
     $stop_pos3 = rindex($seq,"TAG");
     my @arry = ($stop_pos1,$stop_pos2,$stop_pos3);
     @arry = sort{$a <=> $b} @arry;
     $stop_pos = $arry[-1];
     $fi_utr1 = $ex1_start;
     $fi_utr2 = $ex1_start + $star_pos; 
     $len = length $seq;
     $res = $len-$stop_pos-1;
     $th_utr1 = $ex_end-$res;
     $th_utr2 = $ex_end;
     print "$chr\t$ex1_start\t$ex_end\t$name\t$dire\t$fi_utr1\t$fi_utr2\t$th_utr1\t$th_utr2\n";
    }else{
           $seqnew = reverse $seq;           
           $seqnew =~ tr/ATGC/TACG/;
           $star_pos = index($seqnew,"ATG");
           $stop_pos1 = rindex($seqnew,"TAA");
           $stop_pos2 = rindex($seqnew,"TGA");
            $stop_pos3 = rindex($seqnew,"TAG");
       my @arry = ($stop_pos1,$stop_pos2,$stop_pos3);
       @arry = sort{$a <=> $b} @arry;
       $stop_pos = $arry[-1];
       $fi_utr1 = $ex_end-$star_pos+1;
       $fi_utr2 = $ex_end;
       $len = length $seq;
       $res = $len-$stop_pos-2-2;
       $th_utr2 = $ex1_start+$res;
       $th_utr1 = $ex1_start;
       print "$chr\t$ex1_start\t$ex_end\t$name\t$dire\t$fi_utr1\t$fi_utr2\t$th_utr1\t$th_utr2\n";

           

}

    }
}
close IM;
