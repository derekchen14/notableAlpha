class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  before_save { |user| user.email = email.downcase }
  before_validation :make_username
  before_create :make_onboarding_notes
  
  attr_accessor :current_password
  attr_accessible :email, :remember_me, :username, :phone_number, :sendhub_id,
    :password, :password_confirmation, :current_password

  has_many :tags
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

    def make_onboarding_notes
      @onboard_messages = [
        "Click here to edit your notes.",
        "Hover over a note to see the Move handle, which is used for reordering.",
        "You can also delete or duplicate your notes.",
        "Attach images or files to your notes for more storage options.",
        "Organize your notes by adding tags or putting them in folders."
      ]
      @onboard_messages.each do |i|
        note = self.notes.build({content: i})
        note.save
      end
    end

    def notebook
      notes
    end
    
end
