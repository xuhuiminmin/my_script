#!/bin/bash
i=0
for fl in `find -name isoseq_flnc.fasta`
do
dir="$i"_clusterout
echo "#!/bin/bash
#$ -cwd
#$ -S /bin/bash
#$ -j y
#$ -pe mpi 10
#$ -q all.q
pbtranscript cluster $fl unpolised_clustered.fa --quiver --nfl_fa -d $dir ../classifyOut/isoseq_nfl.fasta --ccs_fofn ../ccs/output.ccs.xml --bas_fofn subreads.xml" > cluster_"$i".sh
i=$(($i+1))
done
