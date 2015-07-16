class Specinfra::Parser::Base
  class << self

    class NotImplementedError < Exception; end

    def create
      self
    end

  end
end 
