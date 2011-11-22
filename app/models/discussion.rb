class Discussion < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id, :class_name => "User"
  has_many :messages
  accepts_nested_attributes_for :messages
  
  def initial_message
    @initial_message ||= messages.first
  end
  
  def title
    initial_message.body.truncate(30)
  end
end
