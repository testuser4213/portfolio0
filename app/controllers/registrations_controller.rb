class RegistrationsController < Devise::RegistrationsController

  def account_update_params
    params.require(:user).permit(:avatar, :email, :password, :password_confirmation, :remove_avatar)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
