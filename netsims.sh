#!bin/bash
#
# Network Simulator
#

# fail() is function which is used to close or exit all the fork and thread which is opened or started by the the netsim

fail() {
  echo "$2" >&2
  killall ncat netsims > /dev/null 2>&1
  exit $1
}

# usage() is function which is used to provide the functionality of this simulator.

usage() {
  tab = printf "\t";
  cat << EOF >&2
Usage:
$tab ./netsims.sh alloc <ip subnet> [start_address] [Number_of_ip_addr]
$tab This command is used to simulate >
$tab Example : ./netsims.sh alloc 192.168.10.0 1 15  
$tab This will be done by default....


$tab ./netsims.sh free 
$tab Free the allocated ip addresses 


$tab ./netsims.sh simul <file.conf>
$tab This command is used to start the simulation. Configuration will be read from a config file. File format:
$tab portnumber header
$tab portnumber header
$tab Example : ./netsims.sh simul netsims.conf

$tab Example :Config File:


