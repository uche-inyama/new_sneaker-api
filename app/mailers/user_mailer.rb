class UserMailer < ApplicationMailer
  default from: 'uchenry.iny@gmail.com'

  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3001'
    mail(to: @user.email, subject: 'Welcome to sneaker shop')
  end
end
