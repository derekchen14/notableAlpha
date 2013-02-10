# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  password   :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :email, :phone_number, :password, 
    :password_confirmation, :remember_token, :sendhub_id
  has_secure_password
  has_many :notes, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  before_save :make_username
  before_save :clean_phone_number

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :username, 
  	length: {maximum: 50}  
  validates :email,
    presence: true, 
  	uniqueness: { case_sensitive: false }, 
  	length: {minimum: 7},
  	format: {with: EMAIL_REGEX, on: :create},
  	confirmation: true
	validates :password, 
		length: { minimum: 6 },
    on: :create
	validates :password_confirmation, 
		presence: true,
    :if => :updating_password?


  private
    def updating_password?
      :password.nil?
    end

    def clean_phone_number
      unless self.phone_number.nil?
        self.phone_number = self.phone_number.gsub(/\D/, '')
        #Remove all non-digit symbols
    		if self.phone_number.length == 11 
    			self.phone_number = self.phone_number.sub(/1/, '') 
          #Remove country code "1" at beginning.
    		end
      end
    end

    def make_username
      if self.username.nil?
        self.username = self.email[/[^@]+/]
      end
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def notebook
      notes
    end
    
end
