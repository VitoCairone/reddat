class SessionsController < ApplicationController
  def create
    login
    redirect_to user_url(current_user)
  end

  def new
    @signin_page = true
    render :new
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
