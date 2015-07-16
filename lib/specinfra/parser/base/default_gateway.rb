class Specinfra::Parser::Base::DefaultGateway < Specinfra::Parser::Base
  class << self
    def parse_interface
      /^(\S+)(?: via (\S+))? dev (\S+).+\n(?:default via (\S+))?/.to_s
    end 

    def parse_gateway
      /^(\S+)(?: via (\S+))? dev (\S+).+\n(?:default via (\S+))?/.to_s
    end 
  end 
end 

