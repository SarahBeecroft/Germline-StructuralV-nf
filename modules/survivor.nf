#!/bin/env nextflow

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process survivor_merge {
	debug false
	publishDir "${params.outDir}/${sampleID}/survivor", mode: 'copy'
	container "${params.survivor__container}"
		
	input:
	//tuple val(sampleID), path(mergelist)
	tuple val(sampleID), path(mergeFile)

	output:
	tuple val(sampleID), path("${sampleID}_merged.vcf"), emit: mergedVCF

    script:
	// TODO turn $mergeFile variable into input file
	// currently 
    """
	echo ${mergeFile} | xargs -n1 > ${sampleID}_survivor.txt

	SURVIVOR merge ${sampleID}_survivor.txt \
		1000 1 0 0 0 30 \
		${sampleID}_merged.vcf
	"""
}

process survivor_bed {
	debug false
	publishDir "${params.outDir}/${sampleID}/survivor", mode: 'copy'
	container "${params.survivor__container}"

	input:
	//tuple val(sampleID), path(mergelist)
	tuple val(sampleID), path(mergedVCF)

	output:
	tuple val(sampleID), path("*")

    script:
    """
	SURVIVOR vcftobed ${sampleID}_merged.vcf \
		0 -1 \
		${sampleID}_merged.bed
	"""

}

//process survivor_stats {}