#!/bin/bash

# Name: Parneet Kaur
# Student Number: 2005166246

source reportfunctions.sh




fullScript() {
    HostInfo
    OperatingSystem
    CPU
    Memory
    GraphicSettings
    DiskDrives
    NetworkAdapter
}

# Function to handle errors 
handle_errors() {
    local error_message=$1
    if [ "$VERBOSE" = true ]; then
        # Display error to user if running verbosely
        echo "Error: $error_message" >&2
    else
        # Log error with timestamp
        errormessage "$error_message"
    fi
}

# Check for root permission
if [ "$(id -u)" -ne 0 ]; then
    handle_errors "Script must be run with root permissions. Use sudo or run as root."
    exit 1
fi
fullScript()
