require 'spec_helper'

property[:os] = nil
set :os, :family => 'darwin'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{netstat -rnW -f inet | awk '$1 ~ /default/ {print $1, "via", $2, "dev", $6, " "}'} }
end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{netstat -rnW -f inet6 | awk '$1 ~ /default/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $4, " "}'} }
end
