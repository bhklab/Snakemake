cat "/mnt/work1/users/bhklab/TFRI_Exome/samples.txt" | while read samp ; do

echo "#!/bin/bash
module load python3
python /mnt/work1/users/bhklab/TFRI_Exome/oncokb-annotator/MafAnnotator.py -i /mnt/work1/users/bhklab/TFRI_Exome/MAF_hg38/indel/${samp}/0000.maf \
  -o /mnt/work1/users/bhklab/TFRI_Exome/hg38/indel/${samp}/0000_onco.maf \
  -b ${ONCOKB_API_TOKEN}
" >> /mnt/work1/users/bhklab/TFRI_Exome/jobs/${samp}_indel_38_0000.sh

chmod a+x /mnt/work1/users/bhklab/TFRI_Exome/jobs/${samp}_indel_38_0000.sh
screen -d -m -t ${samp} sh /mnt/work1/users/bhklab/TFRI_Exome/jobs/${samp}_indel_38_0000.sh

done
