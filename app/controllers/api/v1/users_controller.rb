class Api::V1::UsersController < Api::V1::ApplicationController
  def create
    user = User.create!(user_params)
    render json: UsersSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
