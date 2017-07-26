module MailServerActionmailer
  module Api
    class ServerClient
      include FileHelpers

      delegate :request, to: '::MailServerActionmailer::Api::Requests'

      def send_mail(mail)
        request('post', 'mails', mail).body
      end

      def statistic(date = Time.zone.now)
        request('get', 'mails', date: date).body
      end

      def unsubscribe_statistic(date = Time.zone.now)
        request('get', 'events/unsubscribe', events_params(date)).body
      end

      def resubscribe_statistic(date = Time.zone.now)
        request('get', 'events/resubscribe', events_params(date)).body
      end

      def upload_logo(file_name)
        request('post', 'users/logo', file_hash(:logo, file_name)).body
      end

      def events(date = Time.zone.now)
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
