class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])

    respond_with @users
  end

  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  def destroy
    @user.destroy

    render json: '{ "status": "success" }',  status: :ok
  end
end
