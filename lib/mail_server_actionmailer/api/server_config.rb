module MailServerActionmailer
  module Api
    class ServerConfig
      class << self
        attr_accessor :api_public_key, :api_secret_key, :send_callback
      end
    end
  end
end
