module MailServerActionmailer
  module Api
    class DeliveryMethod
      attr_reader :response

      delegate :send_callback, to: 'MailServerActionmailer::Api::ServerConfig'

      def initialize(params); end

      def deliver!(mail)
        @response = client.send_mail(attributes(mail))
        send_callback && send_callback.new(response, mail).call
      end

      def client
        @client ||= ::MailServerActionmailer::Api::ServerClient.new
      end

      def attributes(mail)
        MailServerActionmailer::Api::DeliverFields.call(mail)
      end
    end
  end
end
