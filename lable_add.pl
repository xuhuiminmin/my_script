#!perl -w
my %hash;
open(IN,$ARGV[0]) or die "";
while (<IN>){
        chomp;
        @tp = split(/\n/,$_);
        foreach $i(0..$#tp){
                $n = $tp[$i];
                @da = split (/\s+/,$n);
                if(!exists($hash{$da[5]})){
                                print "###\n";                                  
                                }
                        print "$n\n";
                        $hash{$da[5]} += 1;
                        }
        
        }
close IN;
