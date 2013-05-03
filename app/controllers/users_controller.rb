class UsersController < ApplicationController
  before_filter :authorize_admin!, only: [ :create, :destroy ]

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_password_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, notice: "Your user account has been updated"
    else
      render "edit"
    end
  end

  def create_moderator
    @moderator = User.new(user_params)
    @moderator.moderator = true

    if @moderator.save
      flash[:notice] = "Moderator created successfully."
    else
      flash[:error] = "Moderator failed to be created."
    end

    redirect_to :back
  end

  def destroy_moderator
    @moderator = User.find(params[:id])

    if @moderator.destroy
      flash[:notice] = "Moderator destroyed successfully."
    else
      flash[:error] = "Moderator failed to be destroyed."
    end

    redirect_to :back
  end

  private

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end