#! perl -w
print "java -Xmx60G -jar /public3/stu_zhangqing/software/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar -T HaplotypeCaller -R /public3/stu_zhangqing/Program/04_Litchi_program/assembly/canu_polished/Litc.canu.v1.polished.fa -nct 8\t";
$tmp = `find -name "*.fq.sort.rmdup.realign.bam"`;
@tmpdb = split(/\n/,$tmp);
foreach $i (0..$#tmpdb){
          $name = $tmpdb[$i];
          print "-I $name\t";

}
print "-o Li.snp.vcf";
