class NotableFilepicker < ActiveRecord::Base
  attr_accessible :note_id, :url

  belongs_to :note  
end
