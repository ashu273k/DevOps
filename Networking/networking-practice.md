# Networking Command Practice

Executed on 2026-09-03 from Ubuntu 26.04. The command output below is a snapshot from this machine.

## 1. `ip addr`

```text
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN
	inet 127.0.0.1/8 scope host lo
2: enp61s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 state DOWN
3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP
	inet 10.114.6.22/21 scope global dynamic wlp0s20f3
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 state DOWN
	inet 172.17.0.1/16 scope global docker0
```

**Understanding:** `ip addr` displays network interfaces, their state, MAC addresses, and assigned IPv4/IPv6 addresses. The Wi-Fi interface is currently connected.

## 2. `ip route`

```text
default via 10.114.0.1 dev wlp0s20f3 proto dhcp src 10.114.6.22 metric 600
10.114.0.0/21 dev wlp0s20f3 proto kernel scope link src 10.114.6.22 metric 600
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
```

**Understanding:** `ip route` shows how packets are forwarded. The default gateway is `10.114.0.1`, reached through the Wi-Fi interface.

## 3. `ip link`

```text
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN
2: enp61s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 state DOWN
3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 state DOWN
```

**Understanding:** `ip link` focuses on link-layer interfaces and their operational state. It does not show the IP addresses assigned to them.

## 4. `ip neigh`

```text
10.114.0.1 dev wlp0s20f3 lladdr f4:1e:57:3d:ae:df REACHABLE
10.114.6.102 dev wlp0s20f3 lladdr e4:f0:42:2d:47:f4 REACHABLE
10.114.6.190 dev wlp0s20f3 lladdr bc:0f:f3:31:c9:96 STALE
```

**Understanding:** `ip neigh` shows the ARP/neighbor cache, mapping local IP addresses to link-layer addresses. `REACHABLE` means the neighbor was recently confirmed; `STALE` means it may need confirmation.

## 5. `ping -c 4 127.0.0.1`

```text
4 packets transmitted, 4 received, 0% packet loss
rtt min/avg/max/mdev = 0.036/0.040/0.046/0.003 ms
```

**Understanding:** This checks the local loopback stack without using the physical network. The successful replies show that local IP networking is working.

## 6. `ping -c 4 8.8.8.8`

```text
4 packets transmitted, 4 received, 0% packet loss
rtt min/avg/max/mdev = 9.763/14.657/26.547/6.929 ms
```

**Understanding:** This tests Internet connectivity directly by IP address, avoiding DNS. All packets were received successfully.

## 7. `ping -c 4 google.com`

```text
PING google.com (142.251.221.238)
4 packets transmitted, 4 received, 0% packet loss
rtt min/avg/max/mdev = 25.119/42.606/91.488/28.247 ms
```

**Understanding:** This tests both DNS resolution and Internet connectivity. The hostname resolved to an IP address and all four packets returned.

## 8. `nslookup google.com`

```text
Server:         127.0.0.53
Address:        127.0.0.53#53

Name:   google.com
Address: 142.251.221.238
```

**Understanding:** `nslookup` queries DNS and presents a readable hostname-to-address result. This machine uses the local `systemd-resolved` DNS stub at `127.0.0.53`.

## 9. `dig google.com`

```text
;; ->>HEADER<<- opcode: QUERY, status: NOERROR
;; QUESTION SECTION:
;google.com.                    IN      A
;; ANSWER SECTION:
google.com.             242     IN      A       142.251.221.238
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
```

**Understanding:** `dig` gives detailed DNS diagnostics, including query status, record type, TTL, answer, and DNS server. `NOERROR` indicates a successful query.

## 10. `traceroute google.com`

```text
timeout: failed to execute process: No such file or directory (os error 2)
```

**Understanding:** `traceroute` normally lists the routers, or hops, between this computer and a destination. It could not run because the `traceroute` program is not installed in this environment.

## 11. `ss -tuln`

```text
Netid  State   Local Address:Port
udp    UNCONN  127.0.0.53:53
tcp    LISTEN  127.0.0.1:631
tcp    LISTEN  127.0.0.1:5432
tcp    LISTEN  0.0.0.0:22
tcp    LISTEN  *:80
```

**Understanding:** `ss` displays sockets. `-t` selects TCP, `-u` selects UDP, `-l` shows listening sockets, and `-n` keeps addresses and ports numeric.

## 12. `sudo ss -tulpn`

```text
sudo: interactive authentication is required
```

**Understanding:** This command would show listening TCP/UDP sockets plus the owning process and PID. It needs administrator privileges, which were not available during this non-interactive run.

## 13. `sudo lsof -i`

```text
sudo: interactive authentication is required
```

**Understanding:** `lsof -i` lists processes that have Internet sockets open. `sudo` allows it to inspect sockets belonging to all users, but authentication was required here.

## 14. `curl -I https://google.com`

```text
HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
server: gws
```

**Understanding:** `curl -I` requests only HTTP headers. The `301` status means Google redirects the request to `https://www.google.com/`.

## 15. `hostname`

```text
x002-Aspire-A715-76G
```

**Understanding:** `hostname` prints the computer's current host name, which identifies it on the local network.

## 16. `hostnamectl`

```text
Static hostname: x002-Aspire-A715-76G
Operating System: Ubuntu 26.04 LTS
Kernel: Linux 7.0.0-30-generic
Architecture: x86-64
```

**Understanding:** `hostnamectl` provides the host name together with operating system, kernel, architecture, and hardware information.

## 17. `cat /etc/resolv.conf`

```text
nameserver 127.0.0.53
options edns0 trust-ad
search .
```

**Understanding:** This file tells local programs which DNS resolver to use. The loopback address points to the local `systemd-resolved` stub resolver.

## 18. `nmcli device status`

```text
DEVICE             TYPE      STATE                   CONNECTION
wlp0s20f3          wifi      connected               Uniworld-1
lo                 loopback  connected (externally) lo
docker0            bridge    connected (externally) docker0
enp61s0            ethernet  unavailable             --
```

**Understanding:** `nmcli device status` summarizes NetworkManager devices, their types, current state, and active connection. Wi-Fi is connected and Ethernet is unavailable.

## 19. `ip -s link`

```text
lo          RX bytes 1106954  packets 5521  errors 0  dropped 0
			TX bytes 1106954  packets 5521  errors 0  dropped 0
wlp0s20f3   RX bytes 526159150 packets 520456 errors 0 dropped 1757
```

**Understanding:** `ip -s link` adds traffic statistics to interface information. It helps identify packet counts, errors, and dropped packets on each link.
