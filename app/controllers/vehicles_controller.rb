class VehiclesController < ApplicationController
  before_action :authorized

  def create
    @vehicle = Vehicle.create(ad_params)
    params.require([:vin, :license_number_plate, :make, :model, :user_id])
    if @vehicle.valid?
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  def pending
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @vehicles = Vehicle.all.where(status: 'pending')
      render json: {status: "Success", vehicles: @vehicles}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def approved
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @vehicles = Vehicle.all.where(status: 'approved')
      render json: {status: "Success", vehicles: @vehicles}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def rejected
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @vehicles = Vehicle.all.where(status: 'rejected')
      render json: {status: "Success", vehicles: @vehicles}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def get
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      @vehicle = @user.vehicles.last
      render json: {status: "Success", vehicles: @vehicle}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    params.require([:id, :status])
    if @vehicle.present?
      @vehicle.status = params[:status]
      @vehicle.comment = params[:comment]
      @vehicle.save
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Ad ID!"}, status: 400
    end

    def edit
      @vehicle = Vehicle.find(params[:id])
      params.require([:vin, :license_number_plate, :make, :model])
      if @vehicle.present?
        @vehicle.vin = params[:vin]
        @vehicle.license_number_plate = params[:license_number_plate]
        @vehicle.make = params[:make]
        @vehicle.model = params[:model]
        @vehicle.save
        render json: {status: "Success"}, status: 200
      else
        render json: {error: "Invalid Ad ID!"}, status: 400
      end
  end


  private

  def ad_params
    params.permit(:vin, :license_number_plate, :make, :model, :status, :user_id)
  end
end
