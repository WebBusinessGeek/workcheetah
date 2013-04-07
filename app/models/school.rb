class School < ActiveRecord::Base
  # attr_accessible :currently_attending, :degree_name, :degree_type, :from, :highlights, :name, :till
  belongs_to :resume
end
