class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  before_save { |user| user.email = email.downcase }
  before_validation :make_username
  
  attr_accessor :current_password
  attr_accessible :email, :remember_me, :username, :phone_number, :sendhub_id,
    :password, :password_confirmation, :current_password

  has_many :notes, dependent: :destroy
  # , :order => 'position'

  validates :phone_number, 
    length: {maximum: 10}
  validates :username, 
  	length: {maximum: 50},
    :presence => true

  private

    def make_username
      if self.username.nil?
        self.username = self.email[/[^@]+/]
      end
    end

    def notebook
      notes
    end
    
end
