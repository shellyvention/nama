require 'uri'

class UserMailer < ActionMailer::Base
  default from: "nama@localhost"

  def activation_email(user)
    @user = user
    domain = APP_CONFIG['domain']
    @activation_link = "http://" + domain + "/activate_user/" + user.id.to_s + "/" + user.activation_token
    mail(:to => user.email, :subject => "NaMa User Account Activation")
  end
end
