class Specinfra::Command::Aix::Base::RoutingTable < Specinfra::Command::Base::RoutingTable
  class << self
    def check_has_entry(destination)
      # converting to linux ip route output 
      %Q{netstat -rn -f inet | } +
      %Q{awk '$1 ~ /#{destination}/ {print $1, "via", $2, "dev", $6, " "}'}
    end

    alias :get_entry :check_has_entry

    def check_has_entry6(destination)
      # converting to linux ip route output 
      # omitting scope ID on link local addresses 
      %Q{netstat -rn -f inet6 | } +
      %Q{awk '$1 ~ /#{destination}/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $6, " "}'}
    end

    alias :get_entry6 :check_has_entry6
  end
end
