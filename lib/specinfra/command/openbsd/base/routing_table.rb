class Specinfra::Command::Openbsd::Base::RoutingTable < Specinfra::Command::Base::RoutingTable
  class << self
    def check_has_entry(destination)
      "route -n show -inet -gateway | egrep '^#{destination}' | head -1"
    end

    alias :get_entry :check_has_entry

    def check_has_entry6(destination)
      "route -n show -inet6 -gateway | egrep '^#{destination}' | head -1"
    end

    alias :get_entry6 :check_has_entry6

  end
end
