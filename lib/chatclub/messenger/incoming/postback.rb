module Chatclub
  module Messenger
    module Incoming
      # The Postback class represents an incoming Facebook Messenger postback.
      class Postback
        include Chatclub::Messenger::Incoming::Common

        def payload
          @messaging['postback']['payload']
        end
      end
    end
  end
end
