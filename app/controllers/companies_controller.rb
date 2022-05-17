class CompaniesController < ApplicationController
  before_action :authorized

  def create
    @company = Company.create(company_params)
    params.require([:name, :email, :address, :state, :city, :ntn, :user_id])
    if @company.valid?
      render json: {status: "Success"}, status: 200
    else
      render json: {error: "Invalid Request!"}, status: 400
    end
  end

  def get
    @user = User.find(params[:user_id])
    params.require([:user_id])
    if @user.present?
      if @user.role == 'admin'
        @companies = Company.all
      else
        @ads = @user.company
      end
      render json: {status: "Success", companies: @companies}, status: 200
    else
      render json: {error: "Invalid User ID!"}, status: 400
    end
  end

  private

  def company_params
    params.permit(:name, :email, :address, :state, :city, :ntn, :user_id)
  end

end
