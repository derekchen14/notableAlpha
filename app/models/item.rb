class Item < ActiveRecord::Base
  attr_accessible :data, :variablel, :note_id, :user_id
  belongs_to :note

  validates_presence_of :note_id
  validates_presence_of :user_id
end
