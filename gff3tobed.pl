#!perl -w
open (IN,$ARGV[0]) or die "";
open (OUT,">$ARGV[1]");
while (<IN>){
        chomp;
        @data = split (/\s+/,$_);
        $chrm = $data[0];
        $type = $data[2];
        $numa = $data[3];
        $numb = $data[4];
        $ploy = $data[6];
        $name = $data[8];
        if ($type eq "gene") {
                $name =~ s/;Name=.*//g;
                $name =~ s/ID=//g;
                print OUT "$chrm\t$numa\t$numb\t$name\t0\t$ploy\n";
                }
        }
        close IN;
        close OUT;
