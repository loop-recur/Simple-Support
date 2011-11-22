class ParamAppender
  
  def initialize(url)
    @url = url.to_s
  end
  
  def append(params)
    anchor = params.delete(:anchor)
    params = params.map{|k,v| "#{k}=#{v}"}
    @url += (@url.scan("?").any? ?  "&#{params}" : "?#{params}")
    @url += "##{anchor}" if anchor
    @url
  end
end
