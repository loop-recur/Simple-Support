require 'spec_helper'

describe Message do
  
  context "validations" do
    it { should validate_presence_of(:body) }
  end
  
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:discussion) }
  end
end
