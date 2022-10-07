#! /bin/bash

sudo sysctl --write kernel.core_uses_pid=0
sudo sysctl --write kernel.core_pattern=""
