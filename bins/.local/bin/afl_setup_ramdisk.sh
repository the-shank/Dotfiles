#! /bin/bash

# setup tmpfs on RAM for afl so that it doesnt kill the ssd ¯\_(ツ)_/¯

mkdir -p /tmp/afl-ramdisk
echo "created directory: /tmp/afl-ramdisk"

sudo mount -t tmpfs -o size=10G tmpfs /tmp/afl-ramdisk
echo "mounted a 10GB tmpfs at /tmp/afl-ramdisk"

mkdir -p /tmp/afl-ramdisk/tmpdir
echo "created directory: /tmp/afl-ramdisk/tmpdir"
mkdir -p /tmp/afl-ramdisk/afl_input
echo "created directory: /tmp/afl-ramdisk/afl_input"
mkdir -p /tmp/afl-ramdisk/afl_output
echo "created directory: /tmp/afl-ramdisk/afl_output"

sudo chmod -R 777 /tmp/afl-ramdisk
echo "changed permission on /tmp/afl-ramdisk to 777"

# when running afl-fuzz, point AFL_TMPDIR to this directory
# an example:
# AFL_TMPDIR=/tmp/afl-ramdisk/tmpdir afl-fuzz -i afl_input/ -o afl_output/ <binary>
