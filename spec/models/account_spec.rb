require 'spec_helper'

describe Account do
  
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:admins) }
    it { should have_many(:ticket_holders) }
    it { should have_many(:discussions) }
  end
  
  context "validations" do
    it { should validate_presence_of(:user_id) }
  end
  
end
