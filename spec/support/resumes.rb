def fill_in_account_details
  fill_in "Company Name", with: "ABC Company"
  fill_in "Company Website", with: "http://www.webdesigncompany.net"
  fill_in "Company Phone", with: "(555) 555-5555"
end

def fill_in_contact_details
  fill_in "Name", with: "Ernest Hemingway"
  fill_in "Phone", with: "(555) 555-5555"
  fill_in "Home Address", with: "50 Pennsylvania Avenue"
  fill_in "City", with: "Washington D.C."
  fill_in "Zip", with: "55555"
  fill_in "Email (professional email if different)", with: "example@example.com"
  fill_in "Website", with: "www.example.com"
  fill_in "Twitter", with: "eh"
end

def set_employment_statuses
  select "Employed", from: "Current Employment Status"
end

def set_importance
  select "Very important", from: "Growth potential"
  select "Important", from: "Close to home"
  select "Not important", from: "Freedom"
  select "Very important", from: "Pay structure"
end

def fill_in_experience
  fill_in "Company Name", with: "Black & Decker"
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
  select "Bachelor of Science", from: "Merit Recieved"
  select "Plant Sciences", from: "Course of Study"
  fill_in "School name", with: "Yale"
  select "2009", from: "Year Of Completion"
end

def add_school_to_profile
  click_link "Add Education"
end

def remove_school_from_profile
  click_link "Remove Education"
end

def fill_in_reference
  fill_in "Name", with: "John Doesworth"
  fill_in "Job title", with: "Manager"
  fill_in "Company Name", with: "Somecompany"
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

