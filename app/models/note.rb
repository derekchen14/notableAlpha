class Note < ActiveRecord::Base
  acts_as_list

  attr_accessible :content, :format, :name, :tag_list
  belongs_to :user, touch: true
  has_many :items
  has_many :taggings
  has_many :tags, through: :taggings
  
  validates_presence_of :user_id
  validates_presence_of :content
  validates_presence_of :format

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
  
