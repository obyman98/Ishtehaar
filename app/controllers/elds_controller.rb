class EldsController < ApplicationController
  before_action :authorized

  def create
    @eld = Eld.create(eld_params)
    params.require([:identifier, :mac_address, :wifi_ssid, :password_digest, :user_id])
    if @eld.valid?
      byebug
      user = User.find(@eld.user_id)
      user.update_attribute(:driver_eld_id, @eld.id)
      if user.valid?
        render json: {status: "Success"}, status: 200
      end
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  private

  def eld_params
    params.permit(:identifier, :mac_address, :wifi_ssid, :password_digest, :user_id, :eld_id)
  end
end
