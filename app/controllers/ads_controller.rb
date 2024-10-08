class AdsController < ApplicationController
  before_action :authorized

  def create
    @ad = Ad.create(ad_params)
    params.require([:title, :schedule_date_start, :schedule_date_end, :ad, :user_id])
    if @ad.valid?
      @ad.url = @ad.ad_url
      @ad.save
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  def pending
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @ads = Ad.all.where(status: 'pending')
      else
        @ads = @user.ads.where(status: 'pending')
      end
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def approved
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @ads = Ad.all.where(status: 'approved')
      else
        @ads = @user.ads.where(status: 'approved')
      end
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def rejected
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @ads = Ad.all.where(status: 'rejected')
      else
        @ads = @user.ads.where(status: 'rejected')
      end
      render json: {status: "Success", ads: @ads}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def update
    @ad = Ad.find(params[:id])
    params.require([:id, :status])
    if @ad.present?
      @ad.status = params[:status]
      @ad.comment = params[:comment]
      if params[:status] == 'approved'
        @ad.eld_id = 1
      end
      @ad.save
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Ad ID!"}, status: 400
    end
  end

  def edit
    @ad = Ad.find(params[:id])
    params.require([:title, :schedule_date_start, :schedule_date_end, :ad, :user_id])
    if @ad.present?
      @ad.title = params[:title]
      @ad.schedule_date_start = params[:schedule_date_start]
      @ad.schedule_date_end = params[:schedule_date_end]
      @ad.ad = params[:ad]
      @ad.user_id = params[:user_id]
      @ad.status = 'pending'
      @ad.save
      @ad.update_attribute(:url, @ad.ad_url)
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Ad ID!"}, status: 400
    end
  end

  def assign
    @ad = Ad.find(params[:id])
    params.require([:id, :eld_id, :user_id])
    if @ad.present?
      @ad.eld_id = params[:eld_id]
      @ad.save
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Ad ID!"}, status: 400
    end
  end

  def get
    @ad_urls = Ad.all.where(eld_id: params[:eld_id], status: "approved", created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck(:id, :url)
    params.require(:eld_id)
    render json: {ads: @ad_urls}, status: 200
  end

  private

  def ad_params
    params.permit(:title, :schedule_date_start, :schedule_date_end, :ad, :user_id, :eld_id, :duration)
  end
end
