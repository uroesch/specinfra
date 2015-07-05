require 'spec_helper'

property[:os] = nil
set :os, :family => 'openbsd'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{route -n show -inet -gateway | awk '$1 ~ /default/ {print $1, "via", $2, "dev", $8, " "}'} } 

end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{route -n show -inet6 -gateway | awk '$1 ~ /default/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $8, " "}'} }
end
