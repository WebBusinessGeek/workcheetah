class Todo < ActiveRecord::Base
 include ActiveModel::ForbiddenAttributesProtection
 has_one :event, as: :eventable
 after_create :create_event
 before_destroy :destroy_event

 private
   def create_event
     Event.create!(eventable_id: self.id, eventable_type: self.class.to_s, user_id: self.user_id, title: self.title, start: self.date)
   end
   def destroy_event
    self.event.destroy if self.event.present?
   end
end
