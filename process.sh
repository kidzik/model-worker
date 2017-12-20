ANALYSIS_DIR=analysis
FRAMES_DIR=${ANALYSIS_DIR}/${2}/frames
OUT_DIR=${ANALYSIS_DIR}/${2}/out
PROCESSED_DIR=${ANALYSIS_DIR}/${2}/out-red
mkdir ${ANALYSIS_DIR}/${2}
mkdir ${FRAMES_DIR}
mkdir ${OUT_DIR}
mkdir ${PROCESSED_DIR}
ffmpeg -i ${1} -qscale:v 5 ${FRAMES_DIR}/frame%6d.jpg

/home/lukasz/workspace/caffe_rtpose/build/examples/rtpose/rtpose.bin --image_dir ${FRAMES_DIR} --write_json ${OUT_DIR} --no_display --no_frame_drops
cmd="/home/lukasz/anaconda2/bin/python process.py ${2}"
echo $cmd
eval $cmd
ffmpeg -start_number 1 -framerate 30 -i ${PROCESSED_DIR}/frame%06d.jpg -vcodec libx264 -crf 25 -s 1024x720 downloads/${2}.mp4
