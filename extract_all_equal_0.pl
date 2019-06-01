#!perl -w
open(IN,$ARGV[0]) or die "";
<IN>;
while(<IN>){
     chomp;
     @line = split(/\t/,$_);
     $id = shift @line;
     @data = sort {$a <=> $b}@line;
     if($data[-1]==0 and $data[1] == 0){
     #  print "$line[1]\n";
     $data = join ("\t",@data);   
     print "$id\t$data\n"; 

}
}

close IN;
