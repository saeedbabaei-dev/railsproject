class SessionsController < ApplicationController
  def new
    @login=Register.new
  end
  def show
    @login=Register.find(params[:idewe])
  end
  def create
    username_or_email=params[:username]
    password=params[:password]
    if username_or_email.end_with?('@yahoo.com')
      email=username_or_email
      @login=Register.authenticate_by_email(email,password)
    else
      username=username_or_email
      @login=Register.authenticate_by_username(username,password)
    end

    if @login
      #session[:user_id] = user.id
      if params[:remember_me]
      cookies.permanent[:auth_token] = @login.auth_token
    else
      cookies[:auth_token] = @login.auth_token
    end
    #redirect_to @login, :notice => "Logged in!"
    render "show"
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
  end
  def destroy
    cookies[:auth_token] = nil
    redirect_to root_url, :notice => "logged out!!!!!"
  end
end
