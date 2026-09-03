# System Information Project

This project contains a shell script that gathers and displays system information. The script provides details such as the current date, hostname, username, disk usage, and running processes. It also allows the user to create a directory and saves the list of running processes to a file within that directory.

## Files

- **scripts/system_info.sh**: The main shell script that executes the commands to gather system information.
- **docs/sample-output.txt**: A sample output file demonstrating the results of the script execution.

## Commands Used

1. `date`: Displays the current date and time.
2. `hostname`: Outputs the name of the current host.
3. `whoami`: Shows the username of the current user.
4. `df -h`: Reports disk space usage in a human-readable format.
5. `ps`: Lists the currently running processes.
6. `mkdir`: Creates a new directory.
7. `touch`: Creates a new file.

## Expected Output

When the script is executed, it will display the following information:

- Current Date
- Hostname
- Username
- Disk Usage
- Running Processes

Additionally, it will prompt the user to enter a directory name to create, and it will save the list of running processes to a file named `running_processes.txt` within the created directory.

## Instructions for Running the Script

1. Open a terminal.
2. Navigate to the project directory:
   ```
   cd path/to/system-info-project/scripts
   ```
3. Make the script executable:
   ```
   chmod +x system_info.sh
   ```
4. Run the script:
   ```
   ./system_info.sh
   ```

## Prerequisites

- A Unix-like operating system (Linux, macOS, etc.)
- Bash shell
- Necessary permissions to create directories and files in the desired location.