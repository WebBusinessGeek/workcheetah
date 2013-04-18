class UsersController < ApplicationController
  def change_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_attributes(user_password_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, notice: "Your password has been updated"
    else
      render "edit"
    end
  end

  private

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end