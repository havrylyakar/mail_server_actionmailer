require 'mail_server_actionmailer/api/requests'
require 'mail_server_actionmailer/api/file_helpers'

module MailServerActionmailer
  module Api
    class ServerClient
      include FileHelpers

      def request(*args)
        ::MailServerActionmailer::Api::Requests.request(*args)
      end

      def send_mail(mail)
        request('post', 'mails', mail).body
      end

      def statistic(date = Time.now.getlocal)
        request('get', 'mails', date: date).body
      end

      def unsubscribe_statistic(date = Time.now.getlocal)
        request('get', 'events/unsubscribe', events_params(date)).body
      end

      def resubscribe_statistic(date = Time.now.getlocal)
        request('get', 'events/resubscribe', events_params(date)).body
      end

      def upload_logo(file_name)
        request('post', 'users/logo', file_hash(:logo, file_name)).body
      end

      def events(date = Time.now.getlocal)
        request('get', 'events', events_index_params(date)).body
      end

      def events_params(date)
        {
          date: date,
          fields: { mail: 'email_to,group_id' },
          include: 'mail'
        }
      end

      def events_index_params(date)
        {
          date: date,
          fields: {
            mail: 'email_to,group_id',
            event: 'event_type,link'
          },
          include: 'mail'
        }
      end
    end
  end
end
