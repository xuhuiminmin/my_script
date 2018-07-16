#!perl -w

my %hash ;
open(IN,$ARGV[0]) or die "";
while (<IN>){
        chomp;
        @a = split (/\s+/,$_);
        $id = $a[0];
        $hash{$id} += 1;
        }
        close IN;

open(IM,$ARGV[1]) or die "";
while (<IM>){
        chomp;
        next if (/##/);
        next if (/^\s*$/);
        @b = split (/\s+/,$_);
        $na = $b[-1];
        $na =~ s/;.*//g;
        $na =~ s/-mRNA-1.*//g;
        $na =~ s/ID=//g;
        if (exists($hash{$na})){
                foreach $i(0..$#b){
                        $se = $b[$i];
                        print "$se\t";
                        }
                        print "\n";
                }
        }
        close IM;
