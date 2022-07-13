class UsersController < ApplicationController
  before_action :authorized, except: [:login]

  # REGISTER
  def create
    @user = User.create(user_params)
    params.require([:username, :password, :fullname, :email, :phone, :role])
      if @user.valid?
        token = encode_token({user_id: @user.id})
        UserMailer.signup_confirmation(@user).deliver_later
        render json: {user: @user, token: token}, status: 200
      else
        render json: {error: "Invalid credentials"}, status: 400
      end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: 200
    else
      render json: {error: "Invalid username or password"}, status: 400
    end
  end

  def auto_login
    render json: @user, status: 200
  end

  def show
    @drivers = User.all.where(role: 'driver').pluck(:id, :fullname)
    render json: {drivers: @drivers}, status: 200
  end

  def drivers
    @drivers = User.all.where(role: 'driver')
    render json: {drivers: @drivers}, status: 200
  end

  def update
    if params[:id].blank? # check if email is present
      render json: {error: 'ID not present'}, status: 401
    end

    user = User.find(params[:id])
    if user
      user.update(user_params)
      render json: {message: 'User details has been updated'}, status: 200
    else
      render json: {error: 'User not found....'}, status: 401
    end
  end

  def toggle
    if params[:id].blank? # check if email is present
      render json: {error: 'ID not present'}, status: 401
    end

    user = User.find(params[:id])
    if user
      if user.active
        user.update_attribute(:active, false)
      else
        user.update_attribute(:active, true)
      end
      render json: {message: 'User status has been updated'}, status: 200
    else
      render json: {error: 'User not found....'}, status: 401
    end
  end

  def get
    @user = User.find_by(id: params[:user_id])

    if @user.present?
      render json: @user, status: 200
    else
      render json: {error: "Invalid username"}, status: 400
    end
  end

  private

  def user_params
    params.permit(:username, :password, :fullname, :email, :phone, :role)
  end

end
