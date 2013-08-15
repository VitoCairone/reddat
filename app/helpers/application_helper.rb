module ApplicationHelper

  def give_token
    @user.session_token = SecureRandom.urlsafe_base64(16)
    @user.save!
    session[:session_token] = @user.session_token
  end

  def logout
    @user = current_user

    # valid tokens are 16 characters
    session[:session_token] = SecureRandom.urlsafe_base64(10)
    @user.session_token = SecureRandom.urlsafe_base64(12)
    @user.save!
  end

  def login
    @user = User.find_by_name(params[:user][:name])
    if @user && @user.password == params[:user][:password]
      give_token
    else
      redirect_to new_session_url
    end
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
