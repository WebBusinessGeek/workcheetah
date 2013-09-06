module JobsHelper
  def business_types_collection
    [
      ['Start-up (less than 1 year in operation)', 'start-up'],
      ['Small Business (less than 1 million in annual revenue)', 'small'],
      ['Corporation (more than 1 million in annual revenue)', 'corporation'],
      ['Big Business (more than 10 million in annual revenue)', 'big'],
      ['Sole Proprietor', 'sole-proprietor']
    ]
  end

  def job_types_collection
    [
      ['Outsource this job to an established company or professional freelancer', 'outsource'],
      ['I need a Full-time/Part-time Employee', 'part-or-full-time'],
      ['Whoever is best for the job!', 'best']
    ]
  end
end