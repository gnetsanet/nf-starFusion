process runStarFusion{

	memory 200.GB	

	script:
	"""
	mkdir -p /efs/Mouse_gencode_M20_CTAT_lib_Oct012019.plug-n-play/
	
	mkdir -p /efs/GL261LUC-DFCI_RNA_FASTQS
	
	mkdir -p /efs/GL261LUC-DFCI_STARFusion_OUT

	cd /efs/GL261LUC-DFCI_RNA_FASTQS

	/usr/local/bin/aws s3 cp s3://bioinformatics-analysis/GL261LUC_DFCI/GL261LUC_DCFI.Tumor.RNA.MedGenome.R1.fastq.gz ./
	/usr/local/bin/aws s3 cp s3://bioinformatics-analysis/GL261LUC_DFCI/GL261LUC_DCFI.Tumor.RNA.MedGenome.R2.fastq.gz ./

	cd /efs/Mouse_gencode_M20_CTAT_lib_Oct012019.plug-n-play/

	/usr/local/bin/aws s3 cp s3://bioinformatics-analysis/Mouse_gencode_M20_CTAT_lib_Oct012019.plug-n-play/ctat_genome_lib_build_dir/ ./ctat_genome_lib_build_dir/ --recursive

	/usr/local/src/STAR-Fusion/STAR-Fusion --genome_lib_dir /efs/Mouse_gencode_M20_CTAT_lib_Oct012019.plug-n-play/ctat_genome_lib_build_dir \
             --left_fq /efs/GL261LUC-DFCI_RNA_FASTQS/GL261LUC_DCFI.Tumor.RNA.MedGenome.R1.fastq.gz \
             --right_fq /efs/GL261LUC-DFCI_RNA_FASTQS/GL261LUC_DCFI.Tumor.RNA.MedGenome.R2.fastq.gz \
             --output_dir /efs/GL261LUC-DFCI_STARFusion_OUT
	/usr/local/bin/aws s3 cp /efs/GL261LUC-DFCI_STARFusion_OUT s3://bioinformatics-analysis/GL261LUC_DFCI/GL261LUC_DFCI_STARFusion_OUT/ --recursive
	"""
}
