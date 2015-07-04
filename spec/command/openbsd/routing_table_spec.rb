require 'spec_helper'

property[:os] = nil
set :os, :family => 'openbsd'

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq %Q{route -n show -inet -gateway | egrep '^default' | head -1} }
end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq %Q{route -n show -inet6 -gateway | egrep '^default' | head -1} }
end
