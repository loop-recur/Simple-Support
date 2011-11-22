require 'spec_helper'

describe Router do
  before do
    mask_id = "SSvRVRtJvSLH1l3XVi4Xar55MLMT8cAN0rH0LcfMNpgPuL148neB8vSLHgEJim8zNWLNJbMu+GG2cJz+J6Gf0dW8l6+nWw==NWLN" # {:controller => "discussions", :account_id => 1, :action => "index"}
    @path = Router.path(HashWithIndifferentAccess.new(:discussion => { :deploy_url => "http://looprecur.com" }, "controller" => "wrong", :masked_id => mask_id))
  end
    
  it "sets the controller" do
    @path[:controller].should == "discussions"
    @path["controller"].should be_nil
  end
  
  it "sets the action" do
    @path[:action].should == "index"
  end
  
  it "deciphers the account id" do
    @path[:account_id].should == 1
  end
  
  it "preserves the params" do
    @path[:discussion].should == {"deploy_url" => "http://looprecur.com"}
  end

end
