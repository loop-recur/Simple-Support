class BucketsUser < ActiveRecord::Base
  validates :bucket_id, :user_id, :presence => true
  validates_uniqueness_of :bucket_id, :scope => :user_id
  
  belongs_to :admin, :class_name => "User::Admin", :foreign_key => :user_id
  belongs_to :bucket
end
