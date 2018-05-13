rm ../test_code/knee_OA_staging/data/test_images/*
cp ${1} ../test_code/knee_OA_staging/data/test_images/
cd ../test_code/knee_OA_staging

PRED=`python tools/demo_all_predictions.py --cpu --model MLP | tail -n1`

cp data/output_test_images/* ../../model-worker/downloads/
echo "$PRED" > ../../model-worker/downloads/${2}.txt

