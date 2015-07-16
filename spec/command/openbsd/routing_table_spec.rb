require 'spec_helper'

property[:os] = nil
set :os, :family => 'openbsd'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{route -n show -inet -gateway | awk '$1 ~ /default/ {print $1, "via", $2, "dev", $8, " "}'} } 

end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{route -n show -inet6 -gateway | awk '$1 ~ /default/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $8, " "}'} }
end

str = {} 
## $ route -n show -inet 
str[:ipv4] = <<-EOH 
Routing tables

Internet:
Destination        Gateway            Flags   Refs      Use   Mtu  Prio Iface
default            192.168.7.1        UGS        4       40     -     8 vio1 
127/8              127.0.0.1          UGRS       0        0 32768     8 lo0  
127.0.0.1          127.0.0.1          UHl        1        0 32768     1 lo0  
192.168.7/24       link#2             UC         2        0     -     4 vio1 
192.168.7.1        10:6f:3f:81:24:64  UHLc       1        2     -     4 vio1 
192.168.7.51       00:03:47:0c:a3:26  UHLc       1       48     -     4 vio1 
192.168.7.120      52:54:00:dd:d3:ac  UHLl       0        0     -     1 lo0  
192.168.7.255      link#2             UHLb       0        0     -     1 vio1 
224/4              127.0.0.1          URS        0        0 32768     8 lo0  
EOH

## $ route -n show -inet6 
str[:ipv6] = <<-EOH 
Routing tables

Internet6:
Destination                        Gateway                        Flags   Refs      Use   Mtu  Prio Iface
::/104                             ::1                            UGRS       0        0 32768     8 lo0  
::/96                              ::1                            UGRS       0        0 32768     8 lo0  
default                            fe80::126f:3fff:fe81:2464%vio1 UG         0        0     -    56 vio1 
::1                                ::1                            UHl       14        0 32768     1 lo0  
::1                                ::1                            UH         0        0 32768     4 lo0  
::127.0.0.0/104                    ::1                            UGRS       0        0 32768     8 lo0  
::224.0.0.0/100                    ::1                            UGRS       0        0 32768     8 lo0  
::255.0.0.0/104                    ::1                            UGRS       0        0 32768     8 lo0  
::ffff:0.0.0.0/96                  ::1                            UGRS       0        0 32768     8 lo0  
2002::/24                          ::1                            UGRS       0        0 32768     8 lo0  
2002:7f00::/24                     ::1                            UGRS       0        0 32768     8 lo0  
2002:e000::/20                     ::1                            UGRS       0        0 32768     8 lo0  
2002:ff00::/24                     ::1                            UGRS       0        0 32768     8 lo0  
2a02:168:6611::/64                 link#2                         UC         0        0     -     4 vio1 
2a02:168:6611:0:4433:5174:ab3c:17d8 52:54:00:dd:d3:ac              UHLl       0        0     -     1 lo0  
2a02:168:6611:0:5054:ff:fedd:d3ac  52:54:00:dd:d3:ac              UHLl       0        0     -     1 lo0  
fe80::/10                          ::1                            UGRS       0        0 32768     8 lo0  
fe80::%vio1/64                     link#2                         UC         1        0     -     4 vio1 
fe80::126f:3fff:fe81:2464%vio1     10:6f:3f:81:24:64              UHLc       1        0     -     4 vio1 
fe80::5054:ff:fedd:d3ac%vio1       52:54:00:dd:d3:ac              UHLl       0        0     -     1 lo0  
fe80::%lo0/64                      fe80::1%lo0                    U          0        0 32768     4 lo0  
fe80::1%lo0                        fe80::1%lo0                    UHl        0        0 32768     1 lo0  
fec0::/10                          ::1                            UGRS       0        0 32768     8 lo0  
ff01::/16                          ::1                            UGRS       0        0 32768     8 lo0  
ff01::%vio1/32                     link#2                         UC         0        0     -     4 vio1 
ff01::%lo0/32                      ::1                            UC         0        0 32768     4 lo0  
ff02::/16                          ::1                            UGRS       0        0 32768     8 lo0  
ff02::%vio1/32                     link#2                         UC         0        0     -     4 vio1 
ff02::%lo0/32                      ::1                            UC         0        0 32768     4 lo0  
EOH
