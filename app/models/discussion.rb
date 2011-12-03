class Discussion < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_id, :class_name => "User"
  has_many :messages
  accepts_nested_attributes_for :messages
  validates :user_id, :account_id, :presence => true
  validate :at_least_one_message
  scope :resolved, lambda { where(['resolved = ?', true]) }
  scope :unresolved, lambda { where(['resolved = ? or resolved IS NULL', false]) }
  scope :important, lambda { unresolved.where(['important = ?', true]) }

  def self.unresponded
    unresolved.select{ |d| d.latest_message.user_id == d.user_id }
  end
  
  def self.responded
    unresolved.select{ |d| d.latest_message.user_id != d.user_id }
  end
  
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
  
private
  def at_least_one_message
    errors.add(:base, "You must include a message") unless initial_message.try(:valid?)
  end
end
