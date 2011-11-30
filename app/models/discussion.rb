class Discussion < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id, :class_name => "User"
  has_many :messages
  accepts_nested_attributes_for :messages
  validates :user_id, :account_id, :presence => true
  
  def initial_message
    @initial_message ||= messages.first
  end
  
  def latest_message
    @latest_message ||= messages.last
  end
  
  def title
    initial_message.body.truncate(30)
  end
  
  def times
    @times ||= {:first_received => initial_message.created_at, :last_replied => latest_message.created_at}
  end
end
