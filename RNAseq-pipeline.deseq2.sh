sample_list=$1
reference=$2
gene_gff=$3
number_threads=24
mkdir -p {index,align,stringtie,gene_abound,assembly}

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
    stringtie -p $number_threads -e -B -A gene_abound/${sample_name}.gene_abund.tab -G $gene_gff -o assembly/${sample_name}.gtf align/${sample_name}_sort.bam    
 done
python prepDE.py -i path.txt 
sed  "s/\,/\t/g" gene_count_matrix.csv > gene_count_matrix.txt
trinityrnaseq-Trinity-v2.6.5/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix gene_count_matrix.txt --method DESeq2 --samples_file samples_described.txt --contrasts contrast.txt

less -S difference/all_compare_diff/gene_exp.diff |grep "yes"|awk '$10<0' > difference/all_compare_diff/gene_exp_down.txt
less -S difference/all_compare_diff/gene_exp.diff |grep "yes"|awk '$10>0' > difference/all_compare_diff/gene_exp_up.txt

