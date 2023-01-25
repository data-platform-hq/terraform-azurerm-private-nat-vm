#!/bin/bash

usage() {
	echo -e "\e[33m"
	echo "usage: ${0} [-i <eth_interface>] [-s <subnets_cidr_list>]" 1>&2
	echo "where:" 1>&2
	echo "<eth_interface>: Interface on which packet will arrive and be forwarded" 1>&2
	echo "<subnets_cidr_list>: Coma separated list of subnet CIDRS" 1>&2
	echo -e "\e[0m"
}

if [[ $# -eq 0 ]]; then
	echo -e "\e[31mERROR: no options given\e[0m"
	usage
	exit 1
fi

while getopts 'i:s:' OPTS; do
	case "${OPTS}" in
		i)
			echo -e "\e[32mUsing ethernet interface ${OPTARG}\e[0m"
			ETH_IF=${OPTARG}
			;;
		s)
			echo -e "\e[32mSubnet CIDR(s) is(are) ${OPTARG}\e[0m"
			SUBNET_CIDR=${OPTARG}
			;;
		*)
			usage
			exit 1
			;;
	esac
done

if [ -z ${ETH_IF} ]; then
	echo -e "\e[31mERROR: ethernet interface not specified!!!\e[0m"
	usage
	exit 1
fi
if [ -z ${SUBNET_CIDR} ]; then
	echo -e "\e[31mERROR: subnet CIDR(s) is(are) not specified!!!\e[0m"
	usage
	exit 1
fi


#1. Make sure you're root
echo -e "\e[32mChecking whether we're root...\e[0m"
if [ -z ${UID} ]; then
	UID=$(id -u)
fi
if [ "${UID}" != "0" ]; then
	echo -e "\e[31mERROR: user must be root\e[0m"
	exit 1
fi

#2. Make sure IP Forwarding is enabled in the kernel
echo -e "\e[32mEnabling IP forwarding...\e[0m"
echo "1" > /proc/sys/net/ipv4/ip_forward

#3. Do NAT
echo -e "\e[32mCreating iptables rules...\e[0m"
for subnet in ${SUBNET_CIDR//,/ }
do
   iptables -t nat -A POSTROUTING -s ${subnet} -o ${ETH_IF} -j MASQUERADE
   iptables -A FORWARD -s ${subnet} -o ${ETH_IF} -j ACCEPT
   iptables -A FORWARD -d ${subnet} -m state --state ESTABLISHED,RELATED -i ${ETH_IF} -j ACCEPT
   iptables -A INPUT -s ${subnet} -j ACCEPT
done
iptables -A INPUT -m state --state INVALID -j DROP

echo -e "\e[32mDone!\e[0m"
