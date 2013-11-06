class Todo < ActiveRecord::Base
  attr_accessible :date, :title, :user_id
end
