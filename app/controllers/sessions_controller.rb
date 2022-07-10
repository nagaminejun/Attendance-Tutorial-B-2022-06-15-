class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # log_in(user)でも可
      redirect_to user # reidrect_to(user)でも可
    else
      flash.now[:danger] = '認証に失敗！！！！！'
      render :new
    end
  end
  
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
end