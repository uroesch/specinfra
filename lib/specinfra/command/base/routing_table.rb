class Specinfra::Command::Base::RoutingTable < Specinfra::Command::Base
  class << self
    def check_has_entry(destination)
      "ip -4 route show #{destination} | grep #{destination}"
    end

    alias :get_entry :check_has_entry

    def check_has_entry6(destination)
      "ip -6 route show #{destination} | grep #{destination}"
    end

    alias :get_entry6 :check_has_entry6

  end
end
