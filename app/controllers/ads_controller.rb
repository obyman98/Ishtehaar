class AdsController < ApplicationController
  before_action :authorized

  def create
    params.require([:title, :schedule_date_start, :schedule_date_end, :ad, :user_id])
    Ad.create(ad_params)
    render json: {status: "Success"}, status: 200
  end

  def get
    @user = User.find(params[:id])
    @ads = @user.ads
    render json: {status: "Success", ads: @ads}, status: 200
  end

  private

  def ad_params
    params.permit(:title, :schedule_date_start, :schedule_date_end, :ad, :user_id)
  end
end
