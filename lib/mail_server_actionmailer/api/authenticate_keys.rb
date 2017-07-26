module MailServerActionmailer
  module Api
    class AuthenticateKeys
      class << self
        def call(url, params = {})
          new(url, params).perform!
        end
      end

      attr_reader :params, :url

      def initialize(url, params = {})
        @url = url
        @params = params
        configure_defaults!
      end

      def configure_defaults!
        config.public_key = MailServerActionmailer::Api::ServerConfig.api_public_key
        config.secret_key = MailServerActionmailer::Api::ServerConfig.api_secret_key
        # config.public_key = Rails.application.secrets.mail_server_api_public_key
        # config.secret_key = Rails.application.secrets.mail_server_api_secret_key
        config.digest = OpenSSL::Digest::SHA256.new
      end

      def perform!
        {
          sign: calculate_signature(prepare_data),
          pb_key: config.public_key
        }
      end

      def config
        @config ||= OpenStruct.new
      end

      def prepare_data
        url + sorted_keys
      end

      def calculate_signature(data)
        hmac.reset.update(data).to_s
      end

      def hmac
        OpenSSL::HMAC.new(config.secret_key, config.digest)
      end

      def sorted_keys
        @sorted_keys ||= params.keys.sort.join
      end
    end
  end
end
