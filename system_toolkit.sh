#!/bin/bash

# ============================
# WSL System Maintanence ToolKit

while true; do
	echo ""
	echo "=======WSL MaintanenceToolKit=========="
	echo "1. Show System Info"
        echo "2. clean Temproary Files"
        echo "3. Backup A Directory"
        echo "4. Update and Upgrade Packages"
	echo "5. Show Running Processes"
	echo "6. Kill A Process"
	echo "7. Exit"
	echo "======================================="
	read -p "Enter Your Choice: " choice

	case $choice in
		1)
			echo "------SYSTEM INFO------"
			echo "Hostname     : $(hostname)"
			echo "OS Release   : $(lsb_release -d | cut -f2)"
			echo "Uptime       : $(uptime -p)"
			echo "CPU Load     : $(top -bn1 | grep load | awk '{print $10 $11 $12}')"
			echo "Memory       : $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
			echo "Disk Usage   :"
		       	df -h | grep "^/dev"
			;;
		2)
			echo "------CLEAN TEMP FILES------"
			read -p "Enter Directory To Clean (default: /tmp): " dir
			dir=${dir:-/tmp}
			echo "Cleaning Temp Files in $dir..."
			find "$dir" -type f -exec rm -v {} \;
			echo "cleanup Complete."
			;;
		3)
			echo "------BACKUP DIRECTORY------"
			read -p "Enter Directory To Backup: " src
			if [ -d "$src" ]; then
			    dtest="/root/backups"
		    	    mkdir -p "$dtest"
		            dir_name=$(basename "$src")
			    timestamp=$(date +%F_+%H-%M-%S)	                             
			    filename="backup_${dir_name}_${timestamp}.tar.gz"
			    tar -czf "$dest/$filename" "$src"
			    echo "Backup created at: $dest/$filename"
			else
			    echo "Direcory not found: $src"
			fi
			;;
		4)
			echo "------UPDATE AND UPGRADE------"
			sudo apt update && sudo apt upgrade -y
			;;
		5)
			echo "------RUNNING PROCESS------"
			ps aux | less
			;;
		6)
			echo "------KILL A PROCESS------"
			read -p "Enter Process Name: " pname
			pid=$(pgrep "$pname")
			if [ -z "$pid" ]; then
			    echo "No Such Process Running."
    			else
    			    echo "Killing PID: $pid"
			    kill -9 $pid
		            echo "Process Killed"
			fi
			;;
		7)
			echo "GOODBYE"
			break
			;;
		*)
			echo "Invalid Option."
			;;
	esac
done	
