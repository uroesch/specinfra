class Specinfra::Command::Openbsd::Base::RoutingTable < Specinfra::Command::Base::RoutingTable
  class << self
    def check_has_entry(destination)
      # converting to linux ip route output 
      %Q{route -n show -inet -gateway | } + 
      %Q{awk '$1 ~ /#{destination}/ {print $1, "via", $2, "dev", $8, " "}'}
    end

    alias :get_entry :check_has_entry

    def check_has_entry6(destination)
      # converting to linux ip route output 
      # omitting scope ID on link local addresses 
      %Q{route -n show -inet6 -gateway | } + 
      %Q{awk '$1 ~ /#{destination}/ {sub(/%.*/, "", $2); print $1, "via", $2, "dev", $8, " "}'}
    end

    alias :get_entry6 :check_has_entry6

  end
end



