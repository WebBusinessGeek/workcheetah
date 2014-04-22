class ConfirmationsController < ApplicationController
  respond_to :html, :js

  def show
    @confirmation = Confirmation.find_by_confirmation_token(params[:confirmation_token])
    if @confirmation
      sign_in @confirmation.confirm_by, bypass: true
      flash[:notice] = "Successfully signed up, please choose your role and update passwords"
    else
      flash[:notice] = "Confirmation link invalid"
    end
    if @confirmation.confirm_by.role.nil?
      redirect_to edit_user_path
    else
      redirect_to root_path
    end
  end

  def new
    @reference = Reference.find(params[:reference])
    @confirmation = @reference.build_confirmation(email: @reference.email)
    respond_with @confirmation
  end

  def create
    @confirmation = Confirmation.new(confirmation_params)
    @confirmation.confirm_for = current_user
    if @confirmation.save!
      flash[:notice] = "Confirmation successfully created."
      @confirmation.send_email
      ConfirmationMailer.delay.reference_request(@confirmation)
      @confirmation.update_column(:confirmation_sent, Time.now)
    else
      flash[:notice] = "Failure to create request, please try again."
    end
    respond_with @confirmation, location: resume_path(@confirmation.confirmable.resume)
  end

  def reference
    @confirmation = Confirmation.find(params[:id])
    if current_user == @confirmation.confirm_by || current_user.admin?
      @confirmation.confirmable.confirm!
      flash[:notice] = "Thank you for confirming a reference for #{@confirmation.confirm_for.name}"
      redirect_to edit_resume_reference_path(@confirmation.confirmable.resume, @confirmation.confirmable)
    else
      redirect_to :back, notice: "You are not authorized for this request."
    end
  end

  private
    def confirmation_params
      params.require(:confirmation).permit(:email, :message, :confirmable_type, :confirmable_id)
    end
end
