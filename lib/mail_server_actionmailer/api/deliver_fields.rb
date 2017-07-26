require 'mail_server_actionmailer/api/file_helpers'

# frozen_string_literal: true
module MailServerActionmailer
  module Api
    class DeliverFields
      attr_reader :mail, :fields

      include FileHelpers

      class << self
        def call(mail)
          new(mail).attributes
        end
      end

      delegate :attachments, to: :mail

      def initialize(mail, fields = include_attributes)
        @mail = mail
        @fields = fields
      end

      def attributes
        attributes = fields.inject({}) { |acc, elem| acc.merge(elem => send("#{elem}_field")) }
        attachments.any? ? attributes.merge(attachments_hash_field) : attributes
      end

      def include_attributes
        %w(subject text html name_from from name_to to reply_to cc bcc group_id options)
      end

      def options_fields
        %w(footer)
      end

      def default_options
        {
          footer: 'true'
        }.with_indifferent_access
      end

      def options_field
        options_fields
          .inject(default_options) { |acc, elem| mail[elem] ? acc.merge(elem => mail[elem].value) : acc }
      end

      def subject_field
        mail.subject
      end

      def text_field
        mail.text_part&.body&.decoded
      end

      def html_field
        mail.html_part&.body&.decoded
      end

      def name_from_field
        mail[:from].display_names
      end

      def name_to_field
        mail[:to].display_names
      end

      def from_field
        mail[:from].addresses
      end

      def to_field
        mail[:to].addresses
      end

      %w(reply_to cc bcc).each do |name|
        define_method "#{name}_field" do
          format_recipients(mail[name])
        end
      end

      def group_id_field
        mail['group_id']&.value
      end

      def attachments_hash_field
        {
          'attachments' => [
            attachments.inject({}) { |acc, elem| acc.merge(file: upload_io_string(elem)) }
          ]
        }
      end

      private

      def format_recipients(recipients)
        return unless recipients
        recipients = recipients.display_names.zip(recipients.addresses)
        recipients.inject([]) { |acc, elem| acc << format_receipent(elem) }
      end

      def format_receipent(recipient)
        recipient.compact.join(',')
      end
    end
  end
end
