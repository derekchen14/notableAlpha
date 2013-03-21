class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :note
  # attr_accessible :title, :body
end
