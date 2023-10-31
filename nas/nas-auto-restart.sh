#!/bin/sh

# source: https://post.smzdm.com/p/aoowpxq7/
# after gpt tuning

# Configuration
router_ip="192.168.1.1"
check_interval=60
max_failures=10

opt_dir="/var/services/homes/moqi/shell/auto-shutdown"

switch_txt="$opt_dir/switch.txt"

# Initialize failure count
failure_count=0

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# Log filenames with date-stamped
ping_log="$opt_dir/ping-$today.log"
result_log="$opt_dir/result-$today.log"

# Log the start time
current_time=$(date +%Y/%m/%d/%H:%M:%S)
echo "$current_time Starting the script" >> "$result_log"

# Read each line from the switch file
while IFS= read -r switch_status; do
    echo "Switch status is $switch_status" >> "$result_log"

    # Check the switch status
    while [ "$switch_status" -eq 1 ]; do
        # Check if we've crossed into a new day
        new_day=$(date +%Y%m%d)
        if [ "$new_day" != "$today" ]; then
            # Log a message indicating the end of the day's execution
            current_time=$(date +%Y/%m/%d/%H:%M:%S)
            echo "$current_time Execution for today ($today) is complete. Exiting script." >> "$result_log"

            # Exit the script
            exit 0
        fi

        # Ping the router
        if ping -c 4 "$router_ip" > "$ping_log"; then
            # Ping succeeded
            current_time=$(date +%Y/%m/%d/%H:%M:%S)
            echo "$current_time Ping succeeded" >> "$result_log"
            failure_count=0
        else
            # Ping failed
            ((failure_count++))
            current_time=$(date +%Y/%m/%d/%H:%M:%S)
            echo "$current_time Ping failed - Attempt $failure_count" >> "$result_log"

            # Check if the failure count has reached the limit
            if [ "$failure_count" -gt "$max_failures" ]; then
                echo "$current_time Maximum failures reached - Restarting NAS" >> "$result_log"
                # Restart NAS
                synoshutdown --reboot
            fi
        fi

        # Wait for the specified interval before the next check
        sleep "$check_interval"
    done
done < "$switch_txt"
