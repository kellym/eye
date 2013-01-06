require 'celluloid'
require 'active_support'
require 'active_support/time'
require 'active_support/core_ext'
require_relative 'utils/leak_19'

class Eye::Controller
  include Celluloid

  autoload :Load,     'eye/controller/load'
  autoload :Helpers,  'eye/controller/helpers'
  autoload :Commands, 'eye/controller/commands'
  autoload :Status,   'eye/controller/status'

  include Eye::Logger::Helpers
  include Eye::Controller::Load
  include Eye::Controller::Helpers
  include Eye::Controller::Commands
  include Eye::Controller::Status

  attr_reader :applications, :current_config

  def initialize
    @applications = []
    @current_config = {}

    @mutex = Mutex.new

    @logger = Eye::Logger.new "eye"
    Celluloid::logger = @logger

    Eye::SystemResources.setup
  end

end