#! /bin/bash

# setup tmpfs on RAM for afl so that it doesnt kill the ssd ¯\_(ツ)_/¯


mkdir -p /tmp/afl-ramdisk
chmod 777 /tmp/afl-ramdisk

sudo mount -t tmpfs -o size=512M tmpfs /tmp/afl-ramdisk

mkdir -p /tmp/afl-ramdisk/tmpdir
mkdir -p /tmp/afl-ramdisk/afl_input
mkdir -p /tmp/afl-ramdisk/afl_output

# when running afl-fuzz, point AFL_TMPDIR to this directory
# an example:
# AFL_TMPDIR=/tmp/afl-ramdisk/tmpdir afl-fuzz -i afl_input/ -o afl_output/ <binary>
