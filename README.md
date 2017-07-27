# MailServerActionmailer

An MailServerActionmailer is an adapter for sending emails by using MailServer's HTTPS Web API (instead of SMTP).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mail_server_actionmailer', git: 'https://hub.teamvoy.com/teamvoydev/mail_server_actionmailer.git'
```

If you want to use developer's version with your mail server, that run on `localhost:4000`, you can add this line to your application's Gemfile:

```ruby
gem 'mail_server_actionmailer', git: 'https://hub.teamvoy.com/teamvoydev/mail_server_actionmailer.git', branch: 'development_version'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail_server_actionmailer

Then set the delivery method in `config/environments/...`

```ruby
config.action_mailer.delivery_method = :mail_server
```

## Usage

To use mail_server, you must have API KEY, that you can take in MailServer Admin. Then you need setup this configurations:

```ruby
MailServerActionmailer::Api::ServerConfig.api_public_key = Rails.application.secrets.mail_server_api_public_key
MailServerActionmailer::Api::ServerConfig.api_secret_key = Rails.application.secrets.mail_server_api_secret_key
```

Normal ActionMailer usage will now transparently sent by using MailServer's Web API.

`mail` ActionMailer's method may have similar view (to use multipart/alternative content type)

```ruby
  mail(to: 'NameTo <andriy.havrylyak@teamvoy.com>', from: 'NameFrom <andriy.havrylyak+1@teamvoy.com>', group_id: 'your_brodcast', footer: 'false') do |format|
        format.text { render plain: "Hello Mikel!" }
        format.html { render html: "<h1>Hello Developer!</h1>".html_safe }
    end
```

or you can use any other ActionMailer methods.

However, we have some other options:

`group_id` - this is a field for grouping your mail's statistic. If you don't want add mail to statistic, you will set `statistic: 'false' in `mail` method's params.

`footer` - this field means usage default footer. This footer includes unsubscribe and resubscribe links and your company logo(you can upload use API). If you want to use your custom footer and track subscribe and unsubscribe event's statistic, you will need to set next links in your html templates.

```
  <a href = "*|UNSUB|*">Unsubscribe</a>
  <a href = "*|RESUB|*">Resubscribe</a>
```
This links will automatically change our MailServer.

### Callbacks

You may optionally set MailServer's send callback.

```ruby
MailServerActionmailer::Api::ServerConfig.send_callback = ::MailServer::SendMailCallbackService(your class)
```

Callback must have next methods

```ruby
def initialize(response, mail); end

def call; end
```

If you don't want to use callbacks, you can show delivery response call `delivery_method.response` on `::Mail` object

##API

You can use API to get some statistic or some info about your mails

`MailServerActionmailer::Api::Requests.new`

for that use followings methods:

statistic(date_time) - get statistic from time `date_time`

unsubscribe_statistic(date_time) - get events about unsubscribe from time `date_time`

resubscribe_statistic(date_time) - get events about resubscribe from time `date_time`

upload_logo(file_name) - upload logo, that will show in default footer

events(date_time) - get all events(open, click on links, unsubscribe, resubscribe) from time `date_time`

`date_time` must have format `'%Y-%m-%d %T.%L'`.

## Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Merge Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Donation

Give 10$ to the author of this gem
