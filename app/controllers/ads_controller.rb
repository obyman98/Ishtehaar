class AdsController < ApplicationController
  before_action :authorized

  def create
    @ad = Ad.create(ad_params)
    params.require([:title, :schedule_date_start, :schedule_date_end, :ad, :user_id])
    if @ad.valid?
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  def pending
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @ads = @user.ads.where(status: 'pending')
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def approved
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @ads = @user.ads.where(status: 'approved')
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def rejected
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @ads = @user.ads.where(status: 'rejected')
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def update
    @ad = Ad.find(params[:id])
    params.require([:id, :status, :comment])
    if @ad.present?
      @ad.status = params[:status]
      @ad.comment = params[:comment]
      @ad.save
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Ad ID!"}, status: 400
    end
  end

  private

  def ad_params
    params.permit(:title, :schedule_date_start, :schedule_date_end, :ad, :user_id)
  end
end
