# frozen_string_literal: true
module MailServerActionmailer
  module Api
    class Requests
      BASEURI = 'http://51.255.91.111'

      VERSION_PART = '/api/v1/'

      class << self
        def request(http_method, url, params = {})
          new(url, params).send("request_url_#{http_method}")
        end
      end

      attr_reader :url, :params

      def initialize(url, params)
        @url = url
        @params = params
      end

      def request_url_get
        conn.get url do |req|
          req.params = params
          req.headers = authenticate_params
        end
      end

      def request_url_post
        conn.post url do |req|
          req.headers = authenticate_params
          req.body = params
        end
      end

      def conn
        @conn ||= ::Faraday.new(url: "#{BASEURI}#{VERSION_PART}") do |conn|
          conn.request :multipart
          conn.request :url_encoded
          conn.adapter :net_http
        end
      end

      private

      def authenticate_params
        AuthenticateKeys.call("#{VERSION_PART}#{url}", params)
      end
    end
  end
end
