def fill_in_profile_contact_details
  fill_in "Name", with: "Ernest Hemingway"
  fill_in "Phone", with: "(555) 555-5555"
  fill_in "Address 1", with: "50 Pennsylvania Avenue"
  fill_in "Address 2", with: ""
  fill_in "City", with: "Washington D.C."
  fill_in "Zip", with: "55555"
  fill_in "Email", with: "example@example.com"
  fill_in "Website", with: "www.example.com"
  fill_in "Twitter", with: "eh"
end

def set_employment_statuses
  select "Employed", from: "profile_status"
end

def set_importance
  select "Very important", from: "Growth potential"
  select "Important", from: "Close to home"
  select "Not important", from: "Freedom"
  select "Very important", from: "Pay structure"
end

def fill_in_experience
  fill_in "Company name", with: "Black & Decker"
  fill_in "Job title", with: "CEO"
  fill_in "From", with: "01/01/2001"
  fill_in "Till", with: "01/01/2013"
  fill_in "Highlights", with: lorem_ipsum
end

def add_experience_to_profile
  click_link "Add Experience"
end

def remove_experience_from_profile
  click_link "Remove Experience"
end

def fill_in_school
  fill_in "School name", with: "Yale"
  select "Bachelors", from: "Degree type"
  fill_in "Degree name", with: "Business Administration"
  fill_in "From", with: "01/01/#{Date.today.year - 6}"
  fill_in "Till", with: "01/01/#{Date.today.year - 2}"
  fill_in "Highlights", with: lorem_ipsum
end

def add_school_to_profile
  click_link "Add School"
end

def remove_school_from_profile
  click_link "Remove School"
end

def fill_in_reference
  fill_in "Name", with: "John Doesworth"
  fill_in "Job title", with: "Manager"
  fill_in "Company name", with: "Somecompany"
  fill_in "Phone number", with: "555 555 5555"
  fill_in "Email", with: "john@example.com"
  fill_in "Notes", with: lorem_ipsum
  select "Professional", from: "Reference type"
end

def add_reference_to_profile
  click_link "Add Reference"
end

def remove_reference_from_profile
  click_link "Remove Reference"
end

