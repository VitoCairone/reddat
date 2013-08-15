class SessionsController < ApplicationController
  def create
    login
    if logged_in?
      redirect_to user_url(current_user)
    else
      render :new
    end
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
