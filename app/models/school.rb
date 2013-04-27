class School < ActiveRecord::Base
  # attr_accessible :currently_attending, :degree_name, :degree_type, :from, :highlights, :name, :till
  belongs_to :resume

  attr_accessible :name, :degree_type, :degree_name, :from, :till, :currently_attending, :highlights, :resume_id
end
