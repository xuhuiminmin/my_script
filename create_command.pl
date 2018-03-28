#!/usr/bin/perl -w

use Getopt::Std;
getopts "p:i:c:o:";
if ((!defined $opt_p)|| (!defined $opt_i)||(!defined $opt_o)) {
    die "****************************************************************
    Usage: perl $0 -p position -i input file -o command.sh
      -h : help and usage.
      -p : input file position
      -i : input file list(name)
      -o : output file
     Optional:
    
      -t : tinity_denovo
      -g : tinity_guid
      -s : Hist2
      -c : CPU,default 12
****************************************************************\n";
}else{
  print "************************************************************************\n";
  print "Version 1.2\n";
  print "Copyright to miss\n";
  print "RUNNING...\n";
  print "************************************************************************\n";
     }
my $position    = $opt_p;
my $input_list  = $opt_i;
my $cpu         = (defined $opt_c)?$opt_c:"12";
open (OUT,">$opt_o") or die "";
print OUT "#!/bin/bash\n#\$ -cwd\n#\$ -S /bin/bash\n#\$ -j y\n#\$ -pe\tmpi $cpu\n";
open (IN,$input_list) or die "no list";
#open (OUT,'>',$output) or die "";
while (<IN>){
        chomp;
        my @data = split (/\s+/,$_);
  my $sample = $data[0];
     $sample =~ s/_1.clean.fq.gz//g;
  my $outdir = $sample."_trinity_dir";
  my $g_outdir = $sample."guid_trinity_dir";
  my $hisat_out = $sample.".sam";
  my $clean_R1 = $position."/"."$sample"."_1.clean.fq.gz";
  my $clean_R2 = $position."/"."$sample"."_2.clean.fq.gz";
  my $trinity_d = "Trinity --seqType fq --max_memory 50G --left $clean_R1 --right $clean_R2 --CPU $cpu --output $outdir\n";
  my $hist = "hisat2 -p 8 -x genome -1 $clean_R1 -2 $clean_R2 -S $hisat_out\n";
  my $trinity_g =  "Trinity --genome_guided_bam $sample --max_memory 50G --genome_guided_max_intron 10000 --CPU $cpu --output $g_outdir";
print OUT "$trinity_d";
        }
        close IN;
        close OUT;
