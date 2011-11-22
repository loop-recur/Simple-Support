require 'spec_helper'

describe IDMask do
  
  it "serializes the arguments into a simple string" do
    IDMask.mask(1,2,3, "food! and such!").should match(/\S{6,}/)
  end
  
  it "is url safe" do
    IDMask.mask(1,2,3, "food! and such!").should_not match(/\n|\s+|\r|\t|\/|\"/)
  end
  
  it "unserializes the arguments" do
    masked = IDMask.mask("whatever and stuff",2,3)
    IDMask.unmask(masked).should == ["whatever and stuff","2","3"]
  end

end
