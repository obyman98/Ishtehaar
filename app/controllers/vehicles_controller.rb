class VehiclesController < ApplicationController
  before_action :authorized

  def create
    @vehicle = Vehicle.create(ad_params)
    params.require([:vin, :license_number_plate, :make, :model])
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
      if @user.role == 'admin'
        @vehicles = Vehicle.all.where(status: 'pending')
      else
        @vehicles = @user.vehicles.where(status: 'pending')
      end
      render json: {status: "Success", vehicles: @vehicles}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def approved
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @vehicles = Vehicle.all.where(status: 'approved')
      else
        @vehicles = @user.vehicles.where(status: 'approved')
      end
      render json: {status: "Success", vehicles: @vehicles}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  def rejected
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @vehicles = Vehicle.all.where(status: 'rejected')
      else
        @vehicles = @user.vehicles.where(status: 'rejected')
      end
      render json: {status: "Success", vehicles: @vehicles}, status: 200
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
  end


  private

  def ad_params
    params.permit(:vin, :license_number_plate, :make, :model, :status, :user_id)
  end
end
