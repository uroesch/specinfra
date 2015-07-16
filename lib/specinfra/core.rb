require 'specinfra/version'
require 'specinfra/ext'
require 'specinfra/helper'
require 'specinfra/command'
require 'specinfra/command_factory'
require 'specinfra/command_result'
require 'specinfra/backend'
require 'specinfra/configuration'
require 'specinfra/runner'
require 'specinfra/processor'
require 'specinfra/parser'
require 'specinfra/parser_factory'

module Specinfra
  class << self
    def configuration
      Specinfra::Configuration
    end
  end
end
