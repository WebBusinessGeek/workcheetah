class Todo < ActiveRecord::Base
 include ActiveModel::ForbiddenAttributesProtection
end
