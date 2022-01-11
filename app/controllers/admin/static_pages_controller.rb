class Admin::StaticPagesController < Admin::BaseController
  def home; end

  def destroy
    log_out
    redirect_to root_path
  end
end
