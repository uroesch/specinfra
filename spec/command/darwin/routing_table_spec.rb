require 'spec_helper'

str = {}
str[:ipv4] = <<-EOH
Routing tables

Internet:
Destination        Gateway            Flags        Refs      Use   Netif Expire
default            192.168.7.1        UGSc            3        4     en1
10.10.10/24        link#7             UC              2        0    tap0
10.10.10.255       link#7             UHLWbI          1       10    tap0
127                127.0.0.1          UCS             0        0     lo0
127.0.0.1          127.0.0.1          UH              4     1779     lo0
169.254            link#5             UCS             0        0     en1
192.168.7          link#5             UCS             8        0     en1
192.168.7.1        10:6f:3f:81:24:64  UHLWI           3       27     en1   1148
192.168.7.20       2c:9e:fc:95:35:eb  UHLWI           0        0     en1   1130
192.168.7.51       80:1f:2:aa:80:ac   UHLWI           0        0     en1   1175
192.168.7.116      0:24:2c:e8:16:b2   UHLWI           1      152     en1   1152
192.168.7.147      127.0.0.1          UHS             1    85538     lo0
192.168.7.255      link#5             UHLWbI          1       22     en1
EOH

str[:ipv6] = <<-EOH
Routing tables

Internet6:
Destination                             Gateway                         Flags         Netif Expire
default                                 fe80::126f:3fff:fe81:2464%en1   UGc             en1
::1                                     ::1                             UH              lo0
2a02:168:6611::/64                      link#5                          UC              en1
2a02:168:6611::216:cbff:febf:24f3       0:16:cb:bf:24:f3                UHL             lo0
fe80::%lo0/64                           fe80::1%lo0                     Uc              lo0
fe80::1%lo0                             link#1                          UHL             lo0
fe80::%en1/64                           link#5                          UC              en1
fe80::216:cbff:febf:24f3%en1            0:16:cb:bf:24:f3                UHL             lo0
fe80::126f:3fff:fe81:2464%en1           10:6f:3f:81:24:64               UHLW            en1
fe80::%en0/64                           link#6                          UC              en0
ff01::/32                               ::1                             Um              lo0
ff02::/32                               ::1                             UmC             lo0
ff02::/32                               link#5                          UmC             en1
ff02::/32                               link#6                          UmC             en0
EOH

property[:os] = nil
set :os, :family => 'darwin'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{netstat -rnW -f inet | awk '$1 ~ /default/ {print $1, "via", $2, "dev", $6, " "}'} }
end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{netstat -rnW -f inet6 | awk '$1 ~ /default/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $4, " "}'} }
end
