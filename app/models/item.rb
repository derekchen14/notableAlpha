class Item < ActiveRecord::Base
  attr_accessible :data, :variable
  belongs_to :note

  validates_presence_of :note_id
  validates_presence_of :data

end
