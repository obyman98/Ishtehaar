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

  def graph

    events = Event.all.where('duration > ?', 0).group(:ad_id, :duration).sum(:duration)
    ads = Ad.all.pluck(:id,:title).to_h

    graph_points = []
    events.each do |event|
      graph_points.append([ads[event[0][0]],event[1]])
    end

    render json: {data: graph_points, status: 200}, status: 200
  end

  def card
    cards = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck('SUM(duration)','SUM(count)')

    render json: {duration: cards[0][0], count: cards[0][1], status: 200}, status: 200
  end

  private

  def event_params
    params.permit(:lng, :lat, :bulk_data, :eld_id, :event_type)
  end
end
