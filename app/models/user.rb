class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :password, :password_confirmation, :current_password
  attr_accessible :email, :remember_me, :username, :phone_number, :sendhub_id,
    :password, :password_confirmation, :current_password

  has_many :notes, dependent: :destroy, :order => 'position'
  before_save { |user| user.email = email.downcase }
  before_save :make_username
  before_save :clean_phone_number

  validates :username, 
  	length: {maximum: 50}  

  private

    def clean_phone_number
      unless self.phone_number.nil?
        self.phone_number = self.phone_number.gsub(/\D/, '')
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

    def notebook
      notes
    end
    
end
