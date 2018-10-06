Rails.application.configure do
  config.raise_delivery_errors = true

  # Action Mailer Configuration for Sendmail
  # config.delivery_method = :sendmail
  # config.sendmail_settings = {
  #   location: '/usr/sbin/sendmail',
  #   arguments: '-i -f %s' % ENV['MAILER_DOMAIN']
  # }
  # config.perform_deliveries = true
  # config.default_options = {
  #   to: ENV['MAILER_TO'],
  #   sender: 'no-reply@%s' % ENV['MAILER_DOMAIN']
  # }

  # Action Mailer Configuration for Yandex
  config.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.yandex.ru',
    domain: ENV['MAILER_DOMAIN'],
    port: 465,
    user_name: ENV['MAILER_USER_NAME'],
    password: ENV['MAILER_PASSWORD'],
    authentication: 'plain',
    ssl: true
  }
  config.action_mailer.default_options = {
    to: ENV['MAILER_TO'],
    cc: ENV['MAILER_CC'],
    sender: ENV['MAILER_USER_NAME']
  }
end
