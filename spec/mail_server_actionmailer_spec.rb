# require 'spec_helper'
# require 'mail'
# require 'pry'

# RSpec.describe 'MailServerActionmailer' do

# let(:mail_params) { to: 'andriy.havrylyak@teamvoy.com',
#                     from: 'From <andriy.havrylyak+1@teamvoy.com>',
#                     group_id: 'your_brodcast',
#                     footer: 'false',
#                     statistic: 'false'
#                   }
# let(:full_url)
#   { "https://#{MailServerActionmailer::Api::Requests::BASEURI}#{MailServerActionmailer::Api::Requests::VERSION_PART}" }

#   let(:mail) { Mail.new(mail_params) }

#   before do
#     stub_request(:any, full_url)
#       .to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})
#   end

#   it 'should return result' do
#     binding.pry
#   end
# end
