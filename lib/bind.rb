module Bind
  
  def bind(hash)
    hash.each_pair{ |k,v| self.send(:"#{k}=", v) rescue nil }
    self
  end
  
  def bind!(hash)
    hash.each_pair do |k,v|
      success = self.send(:"#{k}=", v) rescue nil
      hash.delete(k) if success
    end
    self
  end
  
end
