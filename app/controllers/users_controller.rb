class UsersController < ApplicationController
  before_filter :authorize_admin!, only: [ :create, :destroy ]

  def edit
    @user = current_user
    render 'payment_recipient' if params["bank_account"]
  end

  def update
    account_update_params = params[:user]
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(user_password_params)
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to account_path(id: @user.account_id), notice: "Your user account has been updated"
    else
      logger.debug @user.errors.inspect
      redirect_to account_path(id: @user.account, part: :login), notice: "Error saving form, please try again."
    end
  end

  def update_bank_account
    recipient = Stripe::Recipient.create(
      name: params[:fullName],
      type: 'individual',
      bank_account: params[:stripeToken]
    )
    if current_user.update_attributes(stripe_recipient_id: recipient.id)
      redirect_to accounts_path(id: current_user.account_id, part: :bank_account), notice: "Bank Account Succesffuly added"
    else
      redirect_to accounts_path(id: current_user.account_id, part: :bank_account)
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
      params.require(:user).permit(:email, :role,  :password, :password_confirmation)
    end

    def user_params
      params.require(:user).permit(:email, :role, :password)
    end
end