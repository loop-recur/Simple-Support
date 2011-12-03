class Discussion
  
describe Finder do
  fixtures :accounts, :discussions
  
  describe "finds" do
    before do
      @account = accounts(:one)
      @unresponded_discussion = discussions(:one)
      @responded_discussion = discussions(:two)
      @resolved_discussion = discussions(:three)
    end
        
    it "returns all unresolved, unresponded discussions" do
      Finder.new(@account, :status => "new").discussions.should == [@unresponded_discussion]
    end
    
    it "returns all unresolved, responded discussions" do
      Finder.new(@account, :status => "pending").discussions.should == [@responded_discussion]
    end
    
    it "returns all resolved discussions" do
      Finder.new(@account, :status => "closed").discussions.should == [@resolved_discussion]
    end
    
    it "returns all unresolved, important discussions" do
      important_discussion = Factory(:discussion, :important => true, :account_id => 1)
      resolved_important_discussion = Factory(:discussion, :important => true, :resolved => true, :account_id => 1)
      Finder.new(@account, :status => "important").discussions.should == [important_discussion]
    end
    
    context "a bucket" do
      before do
        @bucket = Factory(:bucket)
        @unresponded_discussion.update_attribute(:bucket_id, @bucket.id)
      end
      
      it "returns all discussions from a bucket" do
        Finder.new(@account, :queue => {:id => @bucket.id}, :status => "new").discussions.should == [@unresponded_discussion]
      end
      
      it "returns all discussions from a bucket with important status" do
        @responded_discussion.update_attributes(:bucket_id => @bucket.id, :important => true)
        Finder.new(@account, :queue => {:id => @bucket.id}, :status => "important").discussions.should == [@responded_discussion]
      end
    end
  end
end

end
