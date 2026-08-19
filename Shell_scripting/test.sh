#!/bin/bash


# print current date
echo "Current date: $(date)"

# hostname and username
echo "Hostname: $(hostname)"
echo "Username: $(whoami)"

# process
echo "Current processes:"
ps aux | head -10

# add process info inside a file name process.log
ps aux > process.log

# print name,roll_no, comment 
name="Aashu Kumar"
roll_no=10172
comment="class seems to be interactive and fun. I am enjoying it a lot."
echo "My name is $name"
echo "My roll number is $roll_no"
echo "My comment about this class is $comment"

## use variables, take input, create file and directory
dir = read -p "Enter your name: " name
mkdir $dir
cd $dir
echo "This is first log entry\nThis is second log entry" > app.log
cat app.log