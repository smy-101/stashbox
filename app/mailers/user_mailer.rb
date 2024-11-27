class UserMailer < ApplicationMailer
  def welcome_email
    mail(to: "shimy1011@foxmail.com", subject: "stashbox")
  end
end
