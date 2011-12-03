class Bucket < ActiveRecord::Base
  validates :name, :account_id, :presence => true
  
  has_many :buckets_users
  has_many :admins, :class_name => "User::Admin", :through => :buckets_users
  has_many :discussions
  
end
