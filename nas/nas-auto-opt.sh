#!/bin/sh

# functions

# Get config value
get_config_value() {
    # $1 = config file
    # $2 = key
    echo $(cat "$1" | jq -r ".$2")
}

# Function to get current time
get_current_time() {
    echo $(date +%Y-%m-%d\ %H:%M:%S)
}




# dir and json file
opt_dir="/Users/moqi/Downloads/nas-opt"
# opt_dir="/var/services/homes/moqi/shell/auto-opt"

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# Log filenames with date-stamped
log_dir="$opt_dir/log"
ping_log="$log_dir/ping-$today.log"
result_log="$log_dir/result-$today.log"

# Log the start time
current_time=$(get_current_time)
echo "$current_time Starting the script" >> "$result_log"

# Configuration
data_json="$opt_dir/data/nas-auto-opt-data.json"

check_interval=$(get_config_value "$data_json" 'check_interval')
min_failures=$(get_config_value "$data_json" 'min_failures')
min_successes=$(get_config_value "$data_json" 'min_successes')
echo "Init: check_interval is $check_interval, min_failures is $min_failures, min_successes is $min_successes" >> "$result_log"

# Initialize failure and success counts
failure_count=0
success_count=0

while true; do
    check_interval=$(get_config_value "$data_json" 'check_interval')
    min_failures=$(get_config_value "$data_json" 'min_failures')
    min_successes=$(get_config_value "$data_json" 'min_successes')
    router_ip=$(get_config_value "$data_json" 'router_ip')
    switch_status=$(get_config_value "$data_json" 'switch_status')
    echo "check_interval is $check_interval, min_failures is $min_failures, min_successes is $min_successes, router_ip is $router_ip, switch_status is $switch_status" >> "$result_log"

    # Check the switch status
    if [ "$switch_status" -eq 1 ]; then
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

            failure_count=0
            # echo log set failure_count reset to 0.
            echo "$current_time reset failure_count is 0." >> "$result_log"

            echo "$current_time conditions met for nas restart" >> "$result_log"
            # Restart nas
            # synoshutdown --reboot
        fi
    fi

    # Wait for the specified interval before the next check
    sleep "$check_interval"
done