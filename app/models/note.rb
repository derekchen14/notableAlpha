class Note < ActiveRecord::Base
  attr_accessible :content, :format, :item_id, :user_id
end
