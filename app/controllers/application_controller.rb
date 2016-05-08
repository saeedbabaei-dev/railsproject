class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#helper_method :current_user
#private
#def current_user
  #@current_user ||= Register.find(session[:user_id]) if session[:user_id]
#end
private
  def current_user
    @current_user ||= Register.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

protect_from_forgery with: :exception  
end


