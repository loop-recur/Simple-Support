class User < ActiveRecord::Base
  include Role
  
  validates :account_id, :presence => true
  has_attached_file :avatar, PAPERCLIP_DEFAULTS.merge(:default_url => ":class/:style.png",
                                                      :default_style => :default,
                                                      :styles => { :default => "87x87#"})
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  belongs_to :account
  has_many :messages
  has_many :discussions
  
protected

  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end

end
