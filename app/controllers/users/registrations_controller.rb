class Users::RegistrationsController < Devise::RegistrationsController

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :advertiser)
  end
  private :resource_params
end