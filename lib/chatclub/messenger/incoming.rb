require 'chatclub/messenger/incoming/common'
require 'chatclub/messenger/incoming/message'
require 'chatclub/messenger/incoming/delivery'
require 'chatclub/messenger/incoming/postback'
require 'chatclub/messenger/incoming/optin'
require 'chatclub/messenger/incoming/read'
require 'chatclub/messenger/incoming/account_linking'

module Chatclub
  module Messenger
    # The Incoming module parses and abstracts incoming requests from
    # Facebook Messenger.
    module Incoming
      EVENTS = {
        'message' => Message,
        'delivery' => Delivery,
        'postback' => Postback,
        'optin' => Optin,
        'read' => Read,
        'account_linking' => AccountLinking
      }.freeze

      # Parse the given payload.
      #
      # payload - A Hash describing a payload from Facebook.
      #
      # * https://developers.facebook.com/docs/messenger-platform/webhook-reference
      def self.parse(payload)
        EVENTS.each do |event, klass|
          return klass.new(payload) if payload.key?(event)
        end

        raise UnknownPayload, payload
      end

      class UnknownPayload < Chatclub::Messenger::Error; end
    end
  end
end
