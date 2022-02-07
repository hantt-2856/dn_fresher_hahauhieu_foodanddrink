class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    response_page
  end

  private

  def response_page
    return redirect_to admin_root_path if current_user.admin?

    redirect_to root_path
  end
end
