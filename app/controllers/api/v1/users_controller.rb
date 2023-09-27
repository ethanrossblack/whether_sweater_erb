class Api::V1::UsersController < Api::V1::ApplicationController
  def create
    user = User.create!(user_params)
    render json: UsersSerializer.new(user), status: 201
  end

  def login
    user = User.find_by!(email: user_params[:email])
    if user.authenticate(user_params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: {
        errors: [
          {
            status: "401",
            title: "Unauthorized",
            detail: "User credentials are incorrect"
          }
        ]
      }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
