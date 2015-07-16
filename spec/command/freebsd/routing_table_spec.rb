require 'spec_helper'

property[:os] = nil
set :os, :family => 'freebsd'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{netstat -rnW -f inet | awk '$1 ~ /default/ {print $1, "via", $2, "dev", $7, " "}'} }
end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{netstat -rnW -f inet6 | awk '$1 ~ /default/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $7, " "}'} }
end

str = {} 
## netstat -rnW -f inet
str[:ipv4] = <<-EOH 
Routing tables

Internet:
Destination        Gateway            Flags    Refs      Use    Mtu    Netif Expire
default            192.168.7.1        UGS         0        0   1500   vtnet0
127.0.0.1          link#4             UH          0       41  16384      lo0
192.168.7.0/24     link#2             U           0       70   1500   vtnet0
192.168.7.119      link#2             UHS         0        0  16384      lo0
EOH

## netstat -rnW -f inet6 
str[:ipv6] = <<-EOH
Routing tables

Internet6:
Destination                       Gateway                          Flags    Refs      Use    Mtu    Netif Expire
::/96                             ::1                              UGRS        0        0  16384      lo0 =>
default                           fe80::126f:3fff:fe81:2464%vtnet0 UG          0        0   1480   vtnet0
::1                               link#4                           UH          0        0  16384      lo0
::ffff:0.0.0.0/96                 ::1                              UGRS        0        0  16384      lo0
2a02:168:6611::/64                link#2                           U           0        0   1500   vtnet0
2a02:168:6611:0:5054:ff:fea1:d292 link#2                           UHS         0        0  16384      lo0
fe80::/10                         ::1                              UGRS        0        0  16384      lo0
fe80::%vtnet0/64                  link#2                           U           0        0   1500   vtnet0
fe80::5054:ff:fea1:d292%vtnet0    link#2                           UHS         0        0  16384      lo0
fe80::%lo0/64                     link#4                           U           0        0  16384      lo0
fe80::1%lo0                       link#4                           UHS         0        0  16384      lo0
ff01::%vtnet0/32                  fe80::5054:ff:fea1:d292%vtnet0   U           0        0   1500   vtnet0
ff01::%lo0/32                     ::1                              U           0        0  16384      lo0
ff02::/16                         ::1                              UGRS        0        0  16384      lo0
ff02::%vtnet0/32                  fe80::5054:ff:fea1:d292%vtnet0   U           0        0   1500   vtnet0
ff02::%lo0/32                     ::1                              U           0        0  16384      lo0
EOH
