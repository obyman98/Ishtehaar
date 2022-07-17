class CompaniesController < ApplicationController
  before_action :authorized, except: [:create]

  def create
    @company = Company.create(company_params)
    params.require([:name, :email, :address, :state, :city, :ntn, :user_id])
    if @company.valid?
      render json: {status: "Success"}, status: 200
    else
      render json: {error: @company.errors.full_messages}, status: 400
    end
  end

  def get
    if @user.role == 'admin'
      @companies = Company.all
      render json: {status: "Success", companies: @companies}, status: 200
    else
      render json: {error: "You don't have access..."}, status: 400
    end
  end

  def user
    @company_id = Company.find(params[:id])
    @user = User.find(@company_id.user_id)
    params.require([:id])
    if @user.present?
      render json: {status: "Success", vehicles: @user}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  private

  def company_params
    params.permit(:name, :email, :address, :state, :city, :ntn, :user_id)
  end

end
