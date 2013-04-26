require 'spec_helper'

describe "ResumesController" do
  describe "new" do
    before(:each) do
      # create(:user, email: "mr@example.com", password: "password123")
      # visit root_path
      # login_user "mr@example.com", "password123"
      visit new_resume_path
    end

    # it "should allow you to create a new resume" do
    #   fill_in_account_details
    #   fill_in_contact_details
    #   set_employment_statuses

    #   within ".experience" do
    #     fill_in_experience
    #   end
    #   within ".school" do
    #     fill_in_school
    #   end
    #   within ".reference" do
    #     fill_in_reference
    #   end
    #   click_button "Create Resume"
    #   page.should have_content "Resume created successfully"
    #   page.should have_css ".address"
    #   page.should have_css ".reference"
    #   page.should have_css ".school"
    #   page.should have_css ".experience"
    # end

    describe "professional experience section", js: true do
      it "should allow you to add another professional experience" do
        add_experience_to_profile
        all(".experience").count.should == 2
      end

      it "should allow you to remove an experience" do
        add_experience_to_profile
        add_experience_to_profile
        remove_experience_from_profile
        all(".experience", :visible => true).count.should == 2
      end

      it "should allow you to rearrange experiences"
    end

    describe "education section", js: true do
      it "should allow you to add another school" do
        add_school_to_profile
        all(".school").count.should == 2
      end

      it "should allow you to remove a school" do
        add_school_to_profile
        add_school_to_profile
        remove_school_from_profile
        all(".school", :visible => true).count.should == 2
      end

      it "should allow you to rearrange schools"
    end

    describe "references section", js: true do
      it "should allow to you add another references" do
        add_reference_to_profile
        all(".reference").count.should == 2
      end
      it "should allow you to remove a reference" do
        add_reference_to_profile
        add_reference_to_profile
        remove_reference_from_profile
        all(".reference", :visible => true).count.should == 2
      end
    end

    describe "recommendations section" do
      it "should allow to you add another recommendations"
      it "should allow you to remove a recommendation"
    end

    it "should allow them to upload an overview video"
  end
end