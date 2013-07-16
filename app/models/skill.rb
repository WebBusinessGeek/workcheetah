class Skill < ActiveRecord::Base

has_and_belongs_to_many :resumes
belongs_to :skill_group
GROUPED_SKILLS = {
  'Admin Support' => [
    "Administrative Support","Data Entry","Data Clerk",
    "Customer Relations", "Irate Customer Handling",
    "Customer Service", "Inbound Call Handling","Outbound Call Handling",
    "Office Support", "Microsoft Office- intermediate",
    "Microsoft Office- advanced","Microsoft Office- expert"],
  'Writing' => [
   "Creative Writing","Business Writing", "Copywriting", "Content Writing",
   "Editing", "Ghost Writing", "Grant Writing", "Blog Writing",
   "SEO Writing", "Link Building", "Press Release Writing", "Sales Writing",
   "Informative Writing", "Newsletters"],
  'Design & Multimedia'=> [
    "Video Production", "Video Publishing", "Video Editing",
    "Website Design", "Blog Design", "Motion Picture Production",
    "Film Production", "Photography", "Photo Editing", "Photoshop",
    "Graphic Design", "Audio Production", "Audio Engineering",
    "Fashion Design"],
  'Engineering & Manufacturing'=>[
    "Manufacturing", "Manufacturing Design", "Materials Engineering",
    "MathCAD", "Mechanical Design", "Mechanical Engineering",
    "Operations Research", "USB Electronics", "Vector", "Wireless",
    "WI-FI", "WIMAX"],
  'Finance'=> [
    "Financial Analysis", "Analytics", "Auditing", "Bookkeeping",
    "Forecasting", "Business Mathematics", "Business Analysis ", "Financial Reporting",
    "Financial Forecasting", "Accounting", "Accounts Payable", "Accounts Receivable",
    "Budget Management", "Statistics", "Tax Preparation"],
  'Management'=> [
    "Business Mathematics", "Business Analysis", "Economics", "Business Forecasting",
    "Business Strategy", "Data Interpretation", "Leadership Skills", "Staff Development",
    "Motivating"],
  'Human Resources'=>[
    "Benefits Planning", "Disciplinary Action Procedures", "Recruiting",
    "Prospecting Talent", "Training New Hires", "Interviewing", "Developing Staff",
    "Inter-Departmental Coordination"],
  'IT & Programming'=> [
    "CSS", "C+", "C++", "Deployment", "HTML", "Ruby", "Python", "Perl",
    "Rails", "Amazon S3", "Heroku", "Amazon EC2", "Java", "Javascript",
    "Front End Development", "Back End Development", "Website Design",
    "Blog Design", "CMS Development", "Database Development", "SaaS Development",
    "Brochure Website Development", "App Development"],
  'Legal'=> [
    "Benefits Law", "Business Law", "Corporate Law", "Commercial Lending", "Bankruptcy Law",
    "Commercial Trust", "Consumer Protection", "Compensation", "Contract Law", "Copyright",
    "Counseling", "Employment Law", "Environmental Law", "Family Law", "Immigration Law",
    "Licensing", "Law Research", "Litigation", "Medical Law", "Paralegal", "Patent Law",
    "Privacy", "Product Liability", "Real Estate Law", "Trade Law", "Trademarking",
    "Trusts", "Estates", "Wills"],
  'Sales'=> [
    "Prospecting", "Customer Evaluation", "Overcoming Objections", "Negotiating",
    "Presenting", "Product Knowledge Research", "Product Demonstration",
    "Cold-Calling", "Follow Up", "Self Management", "Goal Tracking", "Goal Planning",
    "Contract Reviewing", "Contract Writing", "Lead Generation"],
  'Marketing'=> [
    "Internet Marketing", "Brand Development", "SEM", "SEO", "PPC Campaigns",
    "Link Building", "Content Management", "Social Media Marketing", "Social Bookmarking",
    "Advertising", "Media Marketing", "E-Mail Marketing", "Newsletter Marketing",
    "Content Marketing", "Digital Marketing", "Video Marketing", "Target Market Analysis",
    "Affiliate Marketing"],
  'Public Relations & Press'=> [
    "Press Release Writing", "Press Release Strategy", "Media Marketing",
    "Business Communications", "Journalism", "Reporting", "Story Investigation",
    "Source Confirmation", "Public Speaking"],
  'Talent'=> [
    "Voice Over", "Acting", "Writing", "Voice Acting", "Comedy",
    "Creative Writing", "Non-Fictional Writing"]}

end
