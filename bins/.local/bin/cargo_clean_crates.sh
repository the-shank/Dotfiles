#!/bin/bash

set -eu
set -o pipefail

# ABOUT:
# runs `cargo clean` on all the crates in the CRATES_DIR

# USAGE:
# cargo_clean_crates.sh <CRATES_DIR>

usage() {
	echo "Usage: cargo_clean_crates.sh <CRATES_DIR>"
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

# INPUT:
CRATES_DIR=$1
CRATES_DIR=$(realpath $CRATES_DIR)

# batch size should be (number of cores - 2)
nproc=$(nproc)
max_allowed_nproc=$((nproc - 2))
BATCH_SIZE=$((max_allowed_nproc > 1 ? max_allowed_nproc : 1))

CRATES_DIR=$(realpath $CRATES_DIR)

# ================================

# WORKER:
# the function that runs on a single directory
run_on_one() {
	DIR=$1

	cd $DIR
	cargo +stable clean 2>&1 &>/dev/null
}
export -f run_on_one

# ================================

# WRAPPER:
# the function that runs the worker function and saves the outputs
wrapper() {
	DIR=$1
	idx=$2

	echo ">> processing [$idx]: $(basename $dir)"

	set +e
	bash -c "run_on_one $DIR" &>/dev/null
	exit_code=$?
	# echo ">> exit_code [$idx]: $exit_code"
	set -e

	# echo ">> exit_code: $exit_code"
	if [ $exit_code -eq 0 ]; then
		echo ">> result [$idx]: success"
	else
		echo ">> result [$idx]: failure"
	fi
}

# ================================

# HARNESS:
i=0
# for dir in $(find $CRATES_DIR -mindepth 1 -maxdepth 1 -type d | sort | head -n30); do
for dir in $(find $CRATES_DIR -mindepth 1 -maxdepth 1 -type d | sort); do
	# limit parallel jobs
	while [ $(jobs | wc -l) -ge $BATCH_SIZE ]; do
		wait -n
	done

	i=$((i + 1))
	wrapper $dir $i &
done
wait
