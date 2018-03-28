#!/usr/bin/perl -w

use Getopt::Std;
getopts "p:i:c:o:";
if ((!defined $opt_p)|| (!defined $opt_i)) {
    die "****************************************************************
    Usage: perl $0 -p position -i input file
      -h : help and usage.
      -p : input file position
      -i : input file list(name)
     Optional:
      -c : CPU,default 8
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
my $cpu         = (defined $opt_c)?$opt_c:"8";
open (IN,$input_list) or die "no list";
while (<IN>){
        chomp;
     my @data = split (/\s+/,$_);
     my $sample = $data[0];
     $sample =~ s/.depuplication.result.bam//g;
     $output = "indel".$sample.".sh";
     open ($fh,"> $output") or die"";
     print $fh "#!/bin/bash\n#\$ -cwd\n#\$ -S /bin/bash\n#\$ -j y\n#\$ -pe\tmpi $cpu\n";
     my $outdir = Indel.$sample.sort.rmdup.realign.bam
     my $sample1 = $position."/"."$sample".".depuplication.result.bam";
     my $indel = "java -Xmx60G -jar /public3/stu_zhangqing/software/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T IndelRealigner -R /public3/stu_zhangqing/Program/04_Litchi_program/assembly/canu_polished/Litc.canu.v1.polished.fa  -I $sample1 -log IndelRealigner/Indel.realign.log -targetIntervals IndelRealigner/$sample.realign.intervals -o IndelRealigner/$outdir";
     print $fh "$indel";      }
        close IN;
        close $fh;
