class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # log_in(user)でも可
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user # reidrect_to(user)でも可
    else
      flash.now[:danger] = '認証に失敗！！！！！'
      render :new
    end
  end
  
  def destroy
    # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end