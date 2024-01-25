require "active_ldap"

class LdapUser < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
    prefix: "ou=Departments",
    classes: ["user"]
end
