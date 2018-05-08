#!perl

my %res;
open (IN,$ARGV[0]) or die "";
while (<IN>){
chomp;
$res{$_}++;
}
close IN;
foreach (sort keys(%res)){
print "$_\t$res{$_}\n";

}
