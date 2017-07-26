# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_server_actionmailer/version'

Gem::Specification.new do |spec|
  spec.name          = 'mail_server_actionmailer'
  spec.version       = MailServerActionmailer::VERSION
  spec.authors       = ['andriy.havrylyak']
  spec.email         = ['andriy.havrylyak@teamvoy.com']

  spec.summary       = %q{Phoenix MailServer support for ActionMailer.}
  spec.description   = %q{Use ActionMailer with MailServer's Web API.}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 0.12.1'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5.0'
  spec.add_development_dependency 'mail', '~> 2.6.0'
end
