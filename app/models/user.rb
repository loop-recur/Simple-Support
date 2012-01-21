class User < ActiveRecord::Base
  validates :account_id, :presence => true  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :account
  has_many :messages
  has_many :discussions
  
  def avatar
    User::FakeAvatar
  end
  
protected

  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end

end