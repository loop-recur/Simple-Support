class Account < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user
  has_many :discussions
  has_many :buckets
  has_many :admins, :class_name => "User::Admin", :foreign_key => :account_id
  has_many :ticket_holders, :class_name => "User::TicketHolder", :foreign_key => :account_id
end
