class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]
    @user.save!
    login

    redirect_to user_url(@user)
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def index
    render :index
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save!
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end
end
