#!/bin/sh

# source: https://post.smzdm.com/p/aoowpxq7/
# after gpt tuning

# Configuration
router_ip="192.168.1.1"
check_interval=60
max_failures=10

opt_dir="/var/services/homes/moqi/shell/auto-shutdown"

switch_txt="$opt_dir/switch.txt"
ping_log="$opt_dir/ping.log"
result_log="$opt_dir/result.log"

# Initialize failure count
failure_count=0

# Log the start time
current_time=$(date +%Y/%m/%d/%H:%M:%S)
echo "$current_time Starting the script" >> "$result_log"

# Read each line from the switch file
while IFS= read -r switch_status; do
    echo "Switch status is $switch_status" >> "$result_log"

    # Check the switch status
    while [ "$switch_status" -eq 1 ]; do
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
                echo "$current_time Maximum failures reached - Shutting down" >> "$result_log"
                # Uncomment the next line to enable shutdown
                shutdown -h now
            fi
        fi

        # Wait for the specified interval before the next check
        sleep "$check_interval"
    done
done < "$switch_txt"

