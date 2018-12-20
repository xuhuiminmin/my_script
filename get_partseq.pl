#!perl -w
#####"perl $0 <genome.fa> <weizhi.txt> OUT "
open(IN,$ARGV[0]) or die "";
my %hash;
while(<IN>){
    chomp;
        if(/>/){
        $gene=$_;
        $gene=~ s/>//g;
        $gene=~ s/\s.*//g;
       }else{
       $hash{$gene}.=$_;
}
}
close IN;
foreach $gene(sort keys %hash){
$hash{$gene} =~ s/\s+//g;
#$seq = $hash{$gene};

}
close IN;
open(IM,$ARGV[1]) or die "";
open(OUT,">$ARGV[2]") or die "";
while(<IM>){
      chomp;
      @data = split(/\s+/,$_);
      $id = $data[0];
      $chr = $data[1];
      $polar = $data[4];
     if(exists $hash{$chr}){
       if($polar eq "+"){
      $star = $data[2] -3001;
       $upseq = substr($hash{$chr},$star,3000);
      print OUT ">$id\n$upseq\n";
}else{
      $star = $data[3];
      $upseq = substr($hash{$chr},$star,3000);
      $upseq_new = reverse $upseq;
      $upseq_new =~ tr/ATGC/TACG/;
      print OUT ">$id\n$upseq_new\n"; 
    
}

}

}
close IM;
close OUT;
