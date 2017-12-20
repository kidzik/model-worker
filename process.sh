rm ../knee_OA_staging/data/test_images/*
cp ${1} ../knee_OA_staging/data/test_images/
cd ../knee_OA_staging

python tools/demo_all_predictions.py --cpu MLP

#
# cp knee_OA_staging/data/output_test_images/[FILE] ../model-worker/downloads/[ID]
# SAVE THE LABEL SOMEHOW AND WRITE IT IN ../model-worker/analysis/[]
# 
