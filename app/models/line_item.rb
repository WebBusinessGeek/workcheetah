class LineItem < ActiveRecord::Base
  attr_accessible :hours, :invoice_id, :note, :rate, :task_id
end
