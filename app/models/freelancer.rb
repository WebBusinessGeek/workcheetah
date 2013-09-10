class Freelancer < User
  # attr_accessible :title, :body

  belongs_to :account
end
