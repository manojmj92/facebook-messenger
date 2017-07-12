require 'chatclub/messenger/version'
require 'chatclub/messenger/error'
require 'chatclub/messenger/subscriptions'
require 'chatclub/messenger/thread'
require 'chatclub/messenger/bot'
require 'chatclub/messenger/chatclub'
require 'chatclub/messenger/configuration'
require 'chatclub/messenger/incoming'

module Chatclub
  # All the code for this gem resides in this module.
  module Messenger
    def self.configure
      yield config
    end

    def self.config
      @config ||= Configuration.new
    end

    def self.config=(config)
      @config = config
    end

    configure do |config|
      config.provider = Configuration::Providers::Environment.new
    end
  end
end
