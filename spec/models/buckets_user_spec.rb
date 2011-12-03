require 'spec_helper'

describe BucketsUser do
  before do
    BucketsUser.create(:user_id => 1, :bucket_id => 1)
  end
  
  context "associations" do
    it { should belong_to(:admin) }
    it { should belong_to(:bucket) }
  end
  
  context "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:bucket_id) }
    it { should validate_uniqueness_of(:bucket_id).scoped_to(:user_id) }
  end
  
end
