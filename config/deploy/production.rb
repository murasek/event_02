#aws利用じに仕様
server '52.69.141.156', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/k01_mura/.ssh/id_rsa'



# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings =
# {
 # user_name: ENV['SENDGRID_USERNAME'],
 # password: ENV['SENDGRID_PASSWORD'],
 # domain: "heroku.com",
 # address: "smtp.sendgrid.net",
 # port: 587,
 # authentication: :plain,
 # enable_starttls_auto: true
# }
