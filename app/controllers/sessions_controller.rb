class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t ".login_success"
      log_in user
      redirect_to admin_root_path if is_admin?
      redirect_to root_path unless is_admin?
    else
      flash.now[:warning] = t ".login_fail"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
