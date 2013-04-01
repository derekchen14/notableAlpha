class Tag < ActiveRecord::Base
  attr_accessible :name, :user_id
  belongs_to :user
  has_many :taggings
  has_many :notes, through: :taggings

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens, user_id)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1, user_id: user_id).id }
    tokens.split(',')
  end

end
