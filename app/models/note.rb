class Note < ActiveRecord::Base
  include RankedModel
  ranks :position

  attr_accessible :content, :format
  belongs_to :user
  has_many :items
  
  validates_presence_of :user_id
  validates_presence_of :content
  validates_presence_of :format
  
end
