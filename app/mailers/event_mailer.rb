require 'uri'

class EventMailer < ActionMailer::Base
  default from: "nama@localhost"

  def enrollment_email(event, owner, user)
    @event = event
    @owner = owner
    @user = user
    mail(:to => owner.email, :subject => "NaMa Event Notification")
  end
end
