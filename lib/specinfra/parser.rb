module Specinfra
  module Parser
  end
end

# Base
require 'specinfra/parser/base'
require 'specinfra/parser/base/default_gateway'

# Redhat 
require 'specinfra/parser/redhat'
require 'specinfra/parser/redhat/base'

# Windows 
require 'specinfra/parser/windows'
require 'specinfra/parser/windows/base'
