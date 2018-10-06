class ApplicationMailer < ActionMailer::Base
  default to: '"EXP" <mail@xn--j1aen.xn--80adxhks>'
  default from: ENV['MAILER_USER_NAME']
  default sender: ENV['MAILER_USER_NAME']

  default template_path: 'mailers'

  layout 'mailer'
end
