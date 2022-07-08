class EventsController < ApplicationController
  before_action :authorized, only: []

  def create
    @event = User.create(event_params)
    if @event.valid?
      render json: {message: "Data successfully synced."}, status: 200
    else
      render json: {error: "Invalid credentials"}, status: 400
    end
  end

  private

  def event_params
    params.permit(:lng, :lat, :ad_data, :eld_id)
  end
end
