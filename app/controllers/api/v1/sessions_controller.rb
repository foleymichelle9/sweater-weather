class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])
    if user
      session[:user] = user
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Bad credentials" }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
