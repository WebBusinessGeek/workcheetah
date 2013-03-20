require 'spec_helper'

describe "Job Applications" do
  describe "GET /job/x/job_applications/new" do
    before(:each) do
      @job = FactoryGirl.create(:job)
    end
    it "should allow someone to apply" do
      visit new_job_job_application_path(@job)
    end
  end
end