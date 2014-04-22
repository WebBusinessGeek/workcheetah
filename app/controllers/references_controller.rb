class ReferencesController < ApplicationController
  respond_to :html, :js

  def new
    @resume = Resume.find(params[:resume_id])
    @reference = @resume.references.build
  end

  def create
    @resume = Resume.find(params[:resume_id])
    @reference = @resume.references.build(reference_params)

    if @reference.save
      @confirmation = @reference.create_confirmation(email: @reference.email, confirm_for: current_user)
      @confirmation.send_email
      ConfirmationMailer.delay.reference_request(@confirmation)
      @confirmation.update_column(:confirmation_sent, Time.now)
    else
      flash[:notice] = "Failure to create request, please try again."
    end
    respond_with @reference, location: resume_path(@reference.resume)
  end

  def edit
    @resume = Resume.find(params[:resume_id])
    @reference = @resume.references.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:resume_id])
    @reference = @resume.references.find(params[:id])

    if @reference.update_attributes(reference_params)
      redirect_to root_path, notice: "Thank for you for your feedback."
    else
      logger.debug @reference.errors
      render :edit
    end
  end

  private
    def reference_params
      params.require(:reference).permit(:email, :feedback, :notes, :phone, :job_title, :company, :name, :reference_type )
    end
end
