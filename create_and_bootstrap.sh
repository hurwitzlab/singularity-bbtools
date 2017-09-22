#!/bin/bash

set -x

echo "Hello! starting $(date)"

sudo rm -rf bbtools.img
singularity create -s 1234 bbtools.img
sudo singularity bootstrap bbtools.img ubuntu.sh

echo "Goodbye! ending $(date)"
