class Message < ActiveRecord::Base
  validates :body, :presence => true
  belongs_to :user
  belongs_to :discussion
end
