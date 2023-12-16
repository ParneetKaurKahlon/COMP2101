#!/bin/bash
# Name: Parneet Kaur
# Student number: 200516246



# Function 1
CPU() {
    cat << EOF
----------------------- CPU Info -----------------------
Model: $(lscpu | grep "Model name" | cut -d':' -f2 | xargs)
Max Speed: $(lscpu | grep "Max Speed" | cut -d':' -f2 | xargs)
Cache Sizes: $(lscpu | grep "L1d cache" | cut -d':' -f2 | xargs)
EOF
}

# Function 2
HostInfo() {
    cat << EOF
----------------------- Host Info -----------------------
Manufacturer: $(dmidecode -s system-manufacturer)
Computer Model: $(dmidecode -s system-product-name)
Serial Number: $(dmidecode -s system-serial-number)
EOF
}

# Function 3
NetworkAdapter() {
    cat << EOF
----------------------- Network Report -----------------------
Installed Network Interfaces:
Manufacturer | Model/Description | Link State | Current Speed | IP Addresses | Bridge Master | DNS Servers | Search Domains
-----------------------------------------------------------------------------------------------------------------------
$(ip -o link show | awk '$2!="lo:" {print $2}' | -n1 ip -o addr show | \
    awk '{print $2" | "$3" | "$9" | "$10" | "$4}' | \
    column -t -s "|" | -n8 bash -c 'echo $0 | grep -q "master" && echo " | Yes" || echo " | No"')
EOF
}



# Function 4
Memory() {
    cat << EOF
----------------------- Memory Info -----------------------
Installed Memory Components:
------------------------------------------------
$(dmidecode -t memory | grep -A6 "Memory Device")
Total Installed RAM: $(free -h | grep "Mem:" | awk '{print $2}')
EOF
}

# Function 5


OperatingSystem() {
    cat << EOF
----------------------- OS Info -----------------------
Linux Distro: $(lsb_release -d | cut -d':' -f2 | xargs)
Distro Version: $(lsb_release -r | cut -d':' -f2 | xargs)
EOF
}


# Function 6
DiskDrives() {
    cat << EOF
----------------------- Disk Info -----------------------
Installed Disk Drives:
Manufacturer | Model | Size | Partition | Mount Point | Filesystem Size | Filesystem Free Space
---------------------------------------------------------------------------------------------
$(lsblk -o NAME,MODEL,SIZE,FSTYPE,MOUNTPOINT | awk '$1~/^sd/ {print $2" | "$3" | "$4" | "$1" | "$5" | "$6}' | column -t)
EOF
}

# Function 7
GraphicSettings() {
    cat << EOF
----------------------- Graphic card Info -----------------------
Graphic Card/Chipset Manufacturer: $(lspci | grep VGA | cut -d':' -f3 | xargs)
Graphic Card/Chipset Description or Model: $(lspci | grep VGA | cut -d':' -f3- | xargs)
EOF
}
