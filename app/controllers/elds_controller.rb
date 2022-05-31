class EldsController < ApplicationController
  before_action :authorized

  def create
    @eld = Eld.create(eld_params)
    params.require([:identifier, :mac_address, :wifi_ssid, :password_digest, :user_id])
    if @eld.valid?
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  def get
    @ad_urls = Ad.all.where(eld_id: params[:eld_id]).pluck(:url)
    params.require(:eld_id)
    render json: {ads: @ad_urls}, status: 200
  end

  def show
    @drivers = User.all.where(role: 'driver').pluck(:id, :fullname)
    render json: {ads: @drivers}, status: 200
  end

  private

  def eld_params
    params.permit(:identifier, :mac_address, :wifi_ssid, :password_digest, :user_id, :eld_id)
  end
end