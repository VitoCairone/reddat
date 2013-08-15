class SessionsController < ApplicationController
  def create
    login
    redirect_to user_url(current_user)
  end

  def new
    render :new
  end

  def delete
    logout
  end
end
