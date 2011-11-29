class Message < ActiveRecord::Base
  validates :body, :user_id, :presence => true
  belongs_to :user
  belongs_to :discussion
end
