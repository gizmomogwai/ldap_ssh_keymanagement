# frozen_string_literal: true

require 'ldap_ssh_keymanagement/version'

# methods to help managing ssh keys in activedirectory/ldap
module LdapSshKeymanagement
  require 'net/ldap'

  def self.esr_ldap_connection(account, password)
    Net::LDAP.new(host: '172.31.0.7',
                  port: 389,
                  base: 'cn=users,dc=esrlabs,dc=local',
                  auth: {
                    method: :simple,
                    username: "#{account}@esrlabs.local",
                    password: password
                  })
  end

  def self.ldap_filter_for_user(user)
    "(&(objectClass=user)(sAMAccountName=#{user}))"
  end

  def self.extract_authorized_keys(item)
    item.Info.first.strip.split.map do |s|
      m = s.match(/(.*):(.*)/)
      { host: m[1], key: m[2] }
    end
  end

  def self.get_ssh_keys(user)
    esr_ldap_connection('christian.koestlin.a', 'bl0ck1t!')
      .search(filter: ldap_filter_for_user(user))
      .map { |item| extract_authorized_keys(item) }
      .flatten
  end

  def self.get_ssh_keys_for_host(user, host)
    get_ssh_keys(user)
      .select { |config| config[:host] == host || config[:host] == '*' }
      .map { |config| config[:key] }
      .join("\n")
  end
end
