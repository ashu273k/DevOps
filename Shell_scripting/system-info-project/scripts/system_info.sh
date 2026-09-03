#!/bin/bash

# Store system information in variables
current_date=$(date)
hostname_name=$(hostname)
username=$(whoami)

# Display system information
echo "===== SYSTEM INFORMATION ====="

echo "Current Date: $current_date"
echo "Hostname: $hostname_name"
echo "Username: $username"

echo ""
echo "===== DISK USAGE ====="
df -h

echo ""
echo "===== RUNNING PROCESSES ====="
ps

# Take user input
read -p "Enter the name of a directory to create: " directory_name

# Create directory
mkdir -p "$directory_name"

echo "Directory '$directory_name' created successfully."

# Create a file inside the directory
process_file="$directory_name/running_processes.txt"
touch "$process_file"

# Store running processes in the file using output redirection
ps > "$process_file"

echo "Running processes have been saved to: $process_file"

echo ""
echo "===== SCRIPT COMPLETED ====="