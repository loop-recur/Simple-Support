class Router
  
  def self.path(params)
    new(params).send(:get_path)
  end
  
private

  def initialize(params)
    @params = params.to_hash.symbolize_keys!
    @routing_info = IDMask.unmask(params.delete(:masked_id))
  end
  
  def get_path
    @routing_info.reverse_merge!(@params)
  end

end