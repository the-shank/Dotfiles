#! /usr/bin/env bash

filename=
if [ $# -eq 0 ]
then
    filename="/tmp/afl-ramdisk/afl_input/zero.in"
else
    filename=$1
fi
echo $filename

dd if=/dev/zero of=$filename bs=512 count=1
