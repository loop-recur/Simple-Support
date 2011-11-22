class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  has_many :messages
  has_many :discussions
  
protected

  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end

end
