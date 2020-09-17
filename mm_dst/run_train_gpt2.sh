#!/bin/bash

# PARAMETERS	DEFAUT VALUE
EPOCHS=1	# 1
TRAIN_BATCH=4	# 4
VAL_BATCH=4	# 4
MUL_GPU=1	# 1
GPU_ID='0'	# '0'

PARAMETERS="EPOCHS		$EPOCHS
TRAIN_BATCH	$TRAIN_BATCH
VAL_BATCH	$VAL_BATCH
MUL_GPU		$MUL_GPU
"

if [[ $# -eq 0 ]]
then
	echo "error : run format > ./*.sh (domain) keyword"
	exit 1
fi

if [[ $# -eq 1 ]]
then
	DOMAIN="all"
	KEYWORD=$1
fi

if [[ $# -eq 2 ]]
then
	DOMAIN=$1
	KEYWORD=$2
fi

PATH_DIR=$(realpath .)

if [ $DOMAIN == "furniture_to" ] || [ $DOMAIN == "all" ]
then
# Train (furniture, text-only)
python -m gpt2_dst.scripts.run_language_modeling \
    --output_dir="${PATH_DIR}"/gpt2_dst/save/furniture_to/ \
    --model_type=gpt2 \
    --model_name_or_path=gpt2 \
    --line_by_line \
    --add_special_tokens="${PATH_DIR}"/gpt2_dst/data/furniture_to/special_tokens.json \
    --do_train \
    --train_data_file="${PATH_DIR}"/gpt2_dst/data/furniture_to/furniture_train_dials_target.txt \
    --do_eval \
    --eval_data_file="${PATH_DIR}"/gpt2_dst/data/furniture_to/furniture_dev_dials_target.txt \
    --num_train_epochs=$EPOCH \
    --overwrite_output_dir \
    --per_gpu_train_batch_size=4 \
    --per_gpu_eval_batch_size=4
fi

if [ $domain == "furniture" ] || [ $domain == "all" ]
then
# Train (furniture, multi-modal)
python -m gpt2_dst.scripts.run_language_modeling \
    --output_dir="${PATH_DIR}"/gpt2_dst/save/furniture \
    --model_type=gpt2 \
    --model_name_or_path=gpt2 \
    --line_by_line \
    --add_special_tokens="${PATH_DIR}"/gpt2_dst/data/furniture/special_tokens.json \
    --do_train \
    --train_data_file="${PATH_DIR}"/gpt2_dst/data/furniture/furniture_train_dials_target.txt \
    --do_eval \
    --eval_data_file="${PATH_DIR}"/gpt2_dst/data/furniture/furniture_dev_dials_target.txt \
    --num_train_epochs=1 \
    --overwrite_output_dir \
    --per_gpu_train_batch_size=4 \
    --per_gpu_eval_batch_size=4
fi

if [ $domain == "fashion_to" ] || [ $domain == "all" ]
then
# Train (Fashion, text-only)
python -m gpt2_dst.scripts.run_language_modeling \
    --output_dir="${PATH_DIR}"/gpt2_dst/save/fashion_to \
    --model_type=gpt2 \
    --model_name_or_path=gpt2 \
    --line_by_line \
    --add_special_tokens="${PATH_DIR}"/gpt2_dst/data/fashion_to/special_tokens.json \
    --do_train \
    --train_data_file="${PATH_DIR}"/gpt2_dst/data/fashion_to/fashion_train_dials_target.txt \
    --do_eval \
    --eval_data_file="${PATH_DIR}"/gpt2_dst/data/fashion_to/fashion_dev_dials_target.txt \
    --num_train_epochs=1 \
    --overwrite_output_dir \
    --per_gpu_train_batch_size=4 \
    --per_gpu_eval_batch_size=4
fi

if [ $domain == "fashion" ] || [ $domain == "all" ]
then
# Train (Fashion, multi-modal)
python -m gpt2_dst.scripts.run_language_modeling \
    --output_dir="${PATH_DIR}"/gpt2_dst/save/fashion \
    --model_type=gpt2 \
    --model_name_or_path=gpt2 \
    --line_by_line \
    --add_special_tokens="${PATH_DIR}"/gpt2_dst/data/fashion/special_tokens.json \
    --do_train \
    --train_data_file="${PATH_DIR}"/gpt2_dst/data/fashion/fashion_train_dials_target.txt \
    --do_eval \
    --eval_data_file="${PATH_DIR}"/gpt2_dst/data/fashion/fashion_dev_dials_target.txt \
    --num_train_epochs=1 \
    --overwrite_output_dir \
    --per_gpu_train_batch_size=4 \
    --per_gpu_eval_batch_size=4
fi
