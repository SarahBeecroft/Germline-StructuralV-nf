#!/bin/bash -l 
#SBATCH --job-name=XXX
#SBATCH --account=XXX
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4000M
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mail-user=XXXXX
#SBATCH --mail-type=ALL

module load singularity/3.8.6-nompi
module load nextflow/22.04.3

nextflow run main.nf --input samples.tsv --ref /XXXX/Germline-StructuralV-nf/Homo_sapiens_assembly38.fasta -config config/setonix.config --annotsv Annotations_Human
