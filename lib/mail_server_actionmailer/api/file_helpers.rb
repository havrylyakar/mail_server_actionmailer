module MailServer
  module Api
    module FileHelpers
      def type_file(name)
        MIME::Types.type_for(name).first.content_type
      end

      def file_hash(field, name_file)
        {
          field => Faraday::UploadIO.new(name_file, type_file(name_file))
        }
      end

      def upload_io_string(attachment)
        io = StringIO.new(attachment.body&.raw_source)
        Faraday::UploadIO.new(io, type_file(attachment.filename), attachment.filename)
      end
    end
  end
end
