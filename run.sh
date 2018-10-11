#!/bin/bash

APT_PACKAGES="apt-utils ffmpeg libav-tools x264 x265 wget"
apt-install() {
	export DEBIAN_FRONTEND=noninteractive
	apt-get update -q
	apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" $APT_PACKAGES
	return $?
}

#install ffmpeg to container
add-apt-repository -y ppa:jonathonf/ffmpeg-3 2>&1
apt-install || exit 1

#create folders
# mkdir data
# mkdir data/bin

# train a style in 2 steps
# step 1: setup for training (copied from setup.sh)
# mkdir data
# cd data
# ln -s /storage/public_datasets/coco/coco_train2014/* .
# pwd
# echo Next: which wget
# which wget
# echo Next: which unzip
# which unzip
# /usr/bin/wget http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat
# /usr/bin/wget http://msvocds.blob.core.windows.net/coco2014/train2014.zip
# /usr/bin/unzip train2014.zip
# cd ..
pwd

# step2 2: train
python style.py --style examples/style/wave.jpg \
  --checkpoint-dir ./ \
  --content-weight 1.5e1 \
  --checkpoint-iterations 1000 \
  --batch-size 20 \
  --train-path '/storage/data/train2014' \
  --vgg-path '/storage/data'

#run style transfer on video
# python transform_video.py --in-path examples/content/fox.mp4 \
#  --checkpoint ./scream.ckpt \
#  --out-path /artifacts/out.mp4 \
#  --device /gpu:0 \
#  --batch-size 4 2>&1

#run style transfer on a single image -- adapted from the example in the README.md file 2018.09.29
# python evaluate.py --checkpoint ./scream.ckpt \
# --in-path examples/content/WhatsApp\ Image\ 2018-05-10\ at\ 3.34.49\ PM.jpeg \
# --out-path /artifacts/new.jpg
