require 'spec_helper'
    
describe ParamAppender do
    
  it "adds a param to the end of a url" do
    appender = ParamAppender.new("http://mysite.com")
    appender.append(:thankyou => true).should == "http://mysite.com?thankyou=true"
  end
  
  it "adds a param to the end of a url that already has params" do
    appender = ParamAppender.new("http://mysite.com?some_param=hello")
    appender.append(:thankyou => true).should == "http://mysite.com?some_param=hello&thankyou=true"
  end
  
  it "adds an anchor to the end of the url" do
    appender = ParamAppender.new("http://mysite.com")
    appender.append(:thankyou => true, :anchor => "prospect").should == "http://mysite.com?thankyou=true#prospect"
  end
end
