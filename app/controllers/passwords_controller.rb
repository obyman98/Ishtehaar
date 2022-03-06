class PasswordsController < ApplicationController
  before_action :authorized, only: []

  def forgot
    if params[:email].blank? # check if email is present
      return render json: {error: 'Email not present'}, status: 401
    end

    user = User.find_by(email: params[:email]) # if present find user by email

    if user.present?
      user.generate_password_token! #generate pass token
      UserMailer.forgot_password(user,request.domain).deliver_later
      render json: {status: 'ok'}, status: 200
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: 401
    end
  end

  def reset

    if params[:token].blank?
      return render json: {error: 'Token not present'}, status: 401
    end

    token = params[:token].to_s

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'ok'}, status: 200
      else
        render json: {error: user.errors.full_messages}, status: 400
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: 401
    end
  end
end
