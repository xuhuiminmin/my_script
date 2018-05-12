open(IN, $ARGV[0]) or die "";
$/='>';
<IN>;
while (<IN>){
	chomp;
	my ($name,$seq) = split (/\n/,$_,2);
	$name =~ s/\s+.*//g;
	$seq  =~ s/\s+//g;
	print ">$name\n$seq\n";
	}
	close IN;
