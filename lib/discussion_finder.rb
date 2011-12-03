class DiscussionFinder
  STATUSES = {"new" => :unresponded, "pending" => :responded, "closed" => :resolved, "important" => :important}
  
  def initialize(params, account)
    @params, @account = params, account
  end
  
  def discussions
    @discussions = get_bucket? ? Bucket.find(queue_id).discussions : @account.discussions.unresolved
    @discussions = get_status? ? @discussions.send(status) : @discussions
  end
  
private
  
  def get_status?
    @params[:status]
  end

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
