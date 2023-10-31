#!/bin/sh

# Configuration
check_interval=60
min_failures=10
min_successes=10

opt_dir="/var/services/homes/moqi/shell/auto-opt"

switch_txt="$opt_dir/data/switch.txt"
ping_address_txt="$opt_dir/data/ping_address.txt"

# Initialize failure and success counts
failure_count=0
success_count=0

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# Log filenames with date-stamped
ping_log="$opt_dir/log/ping-$today.log"
result_log="$opt_dir/log/result-$today.log"

# Function to get current time
get_current_time() {
    echo $(date +%Y-%m-%d\ %H:%M:%S)
}

# Log the start time
current_time=$(get_current_time)
echo "$current_time Starting the script" >> "$result_log"

# Read the first line from the ping address file
router_ip=$(head -n 1 "$ping_address_txt")
echo "Ping address is $router_ip" >> "$result_log"

# Read each line from the switch file
while IFS= read -r switch_status; do
    echo "Switch status is $switch_status" >> "$result_log"

    # Check the switch status
    while [ "$switch_status" -eq 1 ]; do
        # Check if we've crossed into a new day
        new_day=$(date +%Y%m%d)
        if [ "$new_day" != "$today" ]; then
            # Log a message indicating the end of the day's execution
            current_time=$(get_current_time)
            echo "$current_time Execution for today ($today) is complete. Exiting script." >> "$result_log"

            # Exit the script
            exit 0
        fi

        # Ping the router
        if ping -c 4 "$router_ip" > "$ping_log"; then
            # Ping succeeded
            current_time=$(get_current_time)
            echo "$current_time Ping to $router_ip succeeded" >> "$result_log"
            ((success_count++))
            failure_count=0
        else
            # Ping failed
            ((failure_count++))
            current_time=$(get_current_time)
            echo "$current_time Ping to $router_ip failed - Attempt $failure_count" >> "$result_log"
            success_count=0
        fi

        current_time=$(get_current_time)
        echo "$current_time failure_count is $failure_count, success_count is $success_count" >> "$result_log"
        echo "" >> "$result_log"

        # Check if the failure count has reached the limit and success count has reached the minimum
        if [ "$failure_count" -ge "$min_failures" ] && [ "$success_count" -ge "$min_successes" ]; then
            echo "$current_time Conditions met for NAS restart" >> "$result_log"
            # Restart NAS
            # synoshutdown --reboot
        fi

        # Wait for the specified interval before the next check
        sleep "$check_interval"
    done
done < "$switch_txt"