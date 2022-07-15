class EventsController < ApplicationController
  require 'net/http'
  before_action :authorized

  def create
    @event = Event.create(event_params)
    if @event.valid?
      render json: {message: "Event successfully created."}, status: 200
    else
      render json: {error: "Invalid credentials"}, status: 400
    end
  end

  def query
    @event = Event.create(event_params)
    if @event.valid?
      GenerateEventsJob.perform_later(event_params)
      render json: {message: "Event successfully created."}, status: 200
    else
      render json: {error: "Invalid credentials"}, status: 400
    end
  end

  private

  def event_params
    params.permit(:lng, :lat, :bulk_data, :eld_id, :event_type)
  end
end
