class ScamReportsController < ApplicationController
  def new
    @scam_report = ScamReport.new
  end

  def create
    @scam_report = ScamReport.new(scam_report_params)
    @scam_report.reporter_ip = request.remote_ip
    @scam_report.user = current_user if user_signed_in?
    @scam_report.save!
    ScamReportMailer.new_scam_report(@scam_report).deliver
    redirect_to root_path, notice: "Thank you for submitting your scam report. We're going to look into this ASAP."
  end

  private

  def scam_report_params
    params.require(:scam_report).permit(:scammer_type, :name_used, :email_used, :phone_number_used, :any_additional_info)
  end
end