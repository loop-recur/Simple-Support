require 'spec_helper'

describe Bucket do
  
  context "associations" do
    it { should have_many(:discussions) }
    it { should have_many(:admins) }
  end
  
  context "validations" do
    it { should validate_presence_of(:account_id) }
    it { should validate_presence_of(:name) }
  end
  
end
