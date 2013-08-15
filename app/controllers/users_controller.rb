class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]
    @user.save!
    login

    redirect_to user_url(@user)
  end

  def show

  end

  def new
    render :new
  end
end
