# !/bin/bash
## Simple iptables firewall for Raspberry Pi, with DROP default policy for incoming traffic. Access allowed only through TCP and UDP port 22.

## Iptables location.
IPTAB=/sbin/iptables

## Configuration files location. Please edit the following files to add/remove addresses. See file headers for further information.
#
## Permitted single IP addresses, domain names and classfull networks.
WL=/etc/myfirewall/whitelist.txt
#
## Permitted IP address ranges.
WL_RNG=/etc/myfirewall/wl_ipranges.txt

## Clear current rules, delete user defined chains, zero counters.
$IPTAB -F
$IPTAB -X
$IPTAB -Z

## Drop everything by default, except outgoing traffic.
$IPTAB -P INPUT DROP
$IPTAB -P OUTPUT ACCEPT
$IPTAB -P FORWARD DROP

## Allow local programs that use loopback (Unix sockets).
$IPTAB -A INPUT -s 127.0.0.0/8 -d 127.0.0.0/8 -i lo -j ACCEPT

## Allow connections from the 192.168.2.0/24 local network.
$IPTAB -A INPUT -s 192.168.2.0/24 -j ACCEPT

## Allow connections from this host to the 192.168.2.0/24 network (yes I know it's not necessary, 'cause OUTPUT policy is ACCEPT... It's just for learning reasons ;-)
$IPTAB -A OUTPUT -d 192.168.2.0/24 -j ACCEPT

## Permits IP addresses, classfull networks and domain names from the whitelist.txt file.
for ip in `grep -v ^# $WL | awk '{print $1'}`
do
echo "+++ Permitting $ip"
$IPTAB -A INPUT -p tcp --dport 22 -s $ip -j ACCEPT
done

## Permits IP address ranges from the the wl_ipranges.txt file.
for ip in `grep -v ^# $WL_RNG | awk '{print $1}'`
do
echo "+++ Permitting IP address range $ip"
$IPTAB -A INPUT -p tcp --dport 22 -m iprange --src-range $ip -j ACCEPT
done

## Ensure that estabilished connections are not checked. I put at the end of the script for monitoring reasons.
$IPTAB -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## Just a small end message.
echo "----------------------------------------------------"
echo "Ready. Execute iptables -vnL for further information"
echo "----------------------------------------------------"
