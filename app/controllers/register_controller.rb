class RegisterController < ApplicationController
  def new
    @user=Register.new
  end
  def show
    #@user=Register.find(params[:id])
  end
  def create
    @user=Register.new(regiter_params)
    if @user.save
      redirect_to  root_url, :notice => "Signed up!"
      #redirect_to @user
     else
       render "new"
    end
  end
  private
    def regiter_params
      params.require(:sign_up).permit(:username, :email, :password)
    end
end
