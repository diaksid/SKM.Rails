# Be sure to restart your server when you modify this file.

if RbConfig::CONFIG['host_os'].match(/mswin|mingw|cygwin/).nil? && ENV['SSL'].present?
  Rails.application.configure do
    config.force_ssl = true
    config.ssl_options = {redirect: {status: 301},
                          hsts: {subdomains: true,
                                 preload: true}}
  end
end
