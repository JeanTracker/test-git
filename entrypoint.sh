#!/bin/sh -l

echo "Hello World: $1"
time=$(date)
echo ::set-output name=time::$time
