class SessionsController < ApplicationController
  def create
    login
    redirect_to user_url(current_user) if logged_in?
  end

  def new
    @signin_page = true #suppress layout header
    render :new
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
