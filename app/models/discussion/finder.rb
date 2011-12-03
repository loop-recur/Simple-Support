class Discussion
  
class Finder
  Discussion.scope :resolved, lambda { Discussion.where(['resolved = ?', true]) }
  Discussion.scope :unresolved, lambda { Discussion.where(['resolved = ? or resolved IS NULL', false]) }
  Discussion.scope :important, lambda { Discussion.unresolved.where(['important = ?', true]) }
  Discussion.scope :unresponded, lambda { Discussion.unresolved.joins(:messages).group("discussions.id").having("count(`messages`.`id`) < 2") }
  Discussion.scope :responded, lambda { Discussion.unresolved.joins(:messages).group("discussions.id").having("count(`messages`.`id`) > 1") }
  
  STATUSES = {"new" => :unresponded, "pending" => :responded, "closed" => :resolved, "important" => :important}
  
  def initialize(account, params)
    @account, @params = account, params
  end
  
  def discussions
    @discussions = get_bucket? ? Bucket.find(queue_id).discussions : @account.discussions
    @discussions.send(status)
  end
  
private
  
  def get_bucket?
    !queue_id.zero?
  end
  
  def queue_id
    @params[:queue][:id].to_i rescue 0
  end
  
  
  def status
    STATUSES[@params[:status]]
  end
end

end