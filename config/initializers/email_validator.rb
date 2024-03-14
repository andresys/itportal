if defined?(EmailValidator)
  EmailValidator.default_options.merge!({
    message: I18n.t('activerecord.errors.messages.must_contain_the_domain'),
    allow_nil: true,
    domain: nil,
    require_fqdn: nil,
    mode: :rfc
  })
end