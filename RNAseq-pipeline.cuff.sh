sample_list=$1
reference=$2
gene_gff=$3
number_threads=24
mkdir -p {index,align,merge,quantify,difference}

##################################################
##step1: create reference_index
 cd ./index
# gffread ../$gene_gff -T -o gene_gtf 
# extract_splice_sites.py gene_gtf  >chrX.ss
# extract_exons.py gene_gtf >chrX.exon
# hisat2-build --ss chrX.ss --exon chrX.exon ../$reference index

##step2: map the clean reads in fq to reference genome by hisat2
# cd ..
 for i in `cut -f 2 sample_list`;do
    sample=${i%_*}
    sample_name=$(basename $sample)
    hisat2 -p $number_threads --dta -x index/index -1 ${sample}_1.fq.gz -2 ${sample}_2.fq.gz |samtools sort -O bam -@ $number_threads -o - > align/${sample_name}_sort.bam
 
   cufflinks -p $number_threads -G $gene_gff -o assembly/${sample_name}_assemble_transcripts align/${sample_name}_sort.bam    
 done
## merge transcripts
find -name transcripts.gtf> assemblly_GTF_list.txt
cuffmerge -g $gene_gff -s $reference -p $number_threads assemblly_GTF_list.txt

##Defference expression
cut -f 1 $sample_list |sort -u |awk '{print "align/"$1"-1_sort.bam,""align/"$1"-2_sort.bam,""align/"$1"-3_sort.bam"}'> name_list
cut -f 1 $sample_list|sort -u > label
name_list2=`awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}' name_list`
label2=`awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str "," a[i,j]}print str}}' label`
cuffdiff -o difference/all_compare_diff -b $reference -p $number_threads -L $label2 -u merged_asm/merged.gtf $name_list2
less -S difference/all_compare_diff/gene_exp.diff |grep "yes"|awk '$10<0' > difference/all_compare_diff/gene_exp_down.txt
less -S difference/all_compare_diff/gene_exp.diff |grep "yes"|awk '$10>0' > difference/all_compare_diff/gene_exp_up.txt
