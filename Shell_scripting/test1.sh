#!/bin/bash

mkdir result_file
cd result_file
touch result.log
echo "This is my result file" > result.log
date
echo $hostname
echo $whoami
df -h
ps > process.log

read -p "Enter your name: " name
read -p "Enter your roll number: " roll_no
read -p "Enter your age: " age