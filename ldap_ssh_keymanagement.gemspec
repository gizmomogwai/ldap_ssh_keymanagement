
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ldap_ssh_keymanagement/version'

Gem::Specification.new do |spec|
  spec.name          = 'ldap_ssh_keymanagement'
  spec.version       = LdapSshKeymanagement::VERSION
  spec.authors       = ['Christian Koestlin']
  spec.email         = ['christian.koestlin@esrlabs.com']

  spec.summary       = 'Gem to manage ssh keys in ldap/active directory.'
  link1 = 'https://blog.laslabs.com/2017/04/managing-ssh-keys-stored-in-active-directory/'
  link2 = 'https://github.com/jirutka/ssh-ldap-pubkey'
  spec.description   = "For technical background see #{link1} or #{link2}."
  spec.homepage      = 'https://github.com/gizmomogwai/ldap_ssh_keymanagement'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'docopt', '~> 0.6'
  spec.add_dependency 'net-ldap', '~> 0.16'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.52.1'
end
