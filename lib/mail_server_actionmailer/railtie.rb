module MailServerActionmailer
  class Railtie < Rails::Railtie
    initializer 'mail_server_api.add_delivery_method', before: 'action_mailer.set_configs' do
      ActionMailer::Base.add_delivery_method(:mail_server,  MailServerActionmailer::Api::DeliveryMethod)
    end
  end
end
