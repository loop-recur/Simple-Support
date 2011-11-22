require 'spec_helper'

describe Message do
  
  context "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:discussion_id) }
  end
  
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:discussion) }
  end
end
