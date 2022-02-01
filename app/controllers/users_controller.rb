class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    params.require([:username, :password, :fullname, :email, :phone, :role])
      if @user.valid?
        token = encode_token({user_id: @user.id})
        UserMailer.test(@user).deliver
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid credentials"}
      end

  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @user
  end


  private

  def user_params
    params.permit(:username, :password, :fullname, :email, :phone, :role)
  end

end
