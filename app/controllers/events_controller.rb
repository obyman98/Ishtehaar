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
    if @user.role == 'admin'
      counts = Event.all.where('count > ?', 0).group(:ad_id, :count).sum(:count)
      locations = Event.all.where('duration > ?', 0).group(:location).count(:location).to_a
    else
      counts = Event.where(ad_id: @user.ads.ids).group(:ad_id).sum(:count)
      locations = Event.where(ad_id: @user.ads.ids).group(:location).count(:location).to_a
    end

    ads = Ad.all.pluck(:id,:title).to_h

    count_points = []
    counts.each do |event|
      count_points.append([ads[event[0][0]],event[1]])
    end

    render json: {counts: count_points, locations: locations, status: 200}, status: 200
  end

  def card
    if @user.role == 'admin'
      cards = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck('SUM(duration)','SUM(count)')
    else
      cards = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, ad_id: @user.ads.ids).pluck('SUM(duration)','SUM(count)')
    end


    render json: {duration: cards[0][0], count: cards[0][1], status: 200}, status: 200
  end

  private

  def event_params
    params.permit(:lng, :lat, :bulk_data, :eld_id, :event_type)
  end
end
