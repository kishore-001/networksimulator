#!/bin/bash

# Network Simulator

# Define devices and network topology
declare -a devices
declare -a topology

LOG_DIR="logs"
LOG_FILE="$LOG_DIR/network_log.txt"

# Ensure log directory exists
mkdir -p $LOG_DIR
> $LOG_FILE

# Function to add devices
add_devices() {
    echo "How many devices do you want to add?"
    read device_count
    for (( i=1; i<=device_count; i++ ))
    do
        devices+=("Device$i")
        echo "Added Device$i" >> $LOG_FILE
    done
    echo "Devices added: ${devices[*]}"
}

# Function to select network topology
select_topology() {
    echo "Select the network topology:"
    echo "1) Bus"
    echo "2) Star"
    echo "3) Ring"
    read topology_choice

    case $topology_choice in
        1) 
            topology="Bus"
            echo "Bus topology selected" >> $LOG_FILE
            ;;
        2) 
            topology="Star"
            echo "Star topology selected" >> $LOG_FILE
            ;;
        3) 
            topology="Ring"
            echo "Ring topology selected" >> $LOG_FILE
            ;;
        *) 
            echo "Invalid choice! Defaulting to Bus topology."
            topology="Bus"
            echo "Default Bus topology selected" >> $LOG_FILE
            ;;
    esac

    echo "Network topology set to: $topology"
}

# Function to simulate packet transmission
transmit_packet() {
    echo "Simulating packet transmission..."
    echo "Select sender device: (e.g., Device1)"
    read sender
    echo "Select receiver device: (e.g., Device2)"
    read receiver
    echo "Enter the message to send:"
    read message

    if [[ " ${devices[*]} " == *" $sender "* ]] && [[ " ${devices[*]} " == *" $receiver "* ]]; then
        echo "Packet sent from $sender to $receiver with message: '$message'" >> $LOG_FILE
        echo "$sender -> $receiver: '$message'"
    else
        echo "Invalid devices! Ensure sender and receiver are valid devices in the network."
    fi
}

# Function to simulate different topologies
simulate_topology() {
    case $topology in
        "Bus")
            echo "Simulating Bus topology..."
            echo "In Bus topology, all devices share a common communication line."
            ;;
        "Star")
            echo "Simulating Star topology..."
            echo "In Star topology, all devices connect to a central hub."
            ;;
        "Ring")
            echo "Simulating Ring topology..."
            echo "In Ring topology, each device is connected in a circular fashion."
            ;;
        *)
            echo "Unknown topology."
            ;;
    esac
}

# Main function
main() {
    echo "=== Welcome to the Network Simulator ==="
    add_devices
    select_topology
    simulate_topology

    while true; do
        echo "1) Transmit Packet"
        echo "2) View Log"
        echo "3) Exit"
        read choice

        case $choice in
            1)
                transmit_packet
                ;;
            2)
                echo "Network Log:"
                cat $LOG_FILE
                ;;
            3)
                echo "Exiting the network simulator. Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid option, please try again."
                ;;
        esac
    done
}

# Start the simulator
main

