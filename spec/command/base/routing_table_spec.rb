require 'spec_helper'

property[:os] = nil
set :os, :family => nil

describe get_command(:get_routing_table_entry, 'default') do
  it { should eq "ip -4 route show default | grep default" } 
end

describe get_command(:get_routing_table_entry6, 'default') do
  it { should eq "ip -6 route show default | grep default" } 
end
