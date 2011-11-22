require 'spec_helper'

describe IDMask do
  
  it "serializes the arguments into a simple string" do
    IDMask.mask({:name => "whatever and stuff", :id => 2, :account_id => 3}).should match(/\S{6,}/)
  end
  
  it "is url safe" do
    IDMask.mask({:name => "whatever and stuff", :id => 2, :account_id => 3}).should_not match(/\n|\s+|\r|\t|\\|\/|\"/)
  end
  
  it "unserializes the arguments" do
    masked = IDMask.mask({:name => "whatever and stuff", :id => 2, :account_id => 3})
    unmasked = IDMask.unmask(masked)
    unmasked[:name].should == "whatever and stuff"
    unmasked[:id].should == 2
    unmasked[:account_id].should == 3
  end

end
