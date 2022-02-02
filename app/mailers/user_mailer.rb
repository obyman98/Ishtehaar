class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject

  default from: "trans.ads.test@gmail.com"
  def signup_confirmation(user)
    @user = user

    #mail to: "to@example.org"
    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def forgot_password(user)
    @user = user

    #mail to: "to@example.org"
    mail to: user.email, subject: "Password Reset Link"
  end

end
