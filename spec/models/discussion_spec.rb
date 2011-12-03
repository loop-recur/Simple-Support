require 'spec_helper'

describe Discussion do
  fixtures :discussions
  
  before do
    @discussion = Factory.build(:discussion)
  end
  
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:messages) }
  end
  
  context "validations" do
    it { should validate_presence_of :account_id }
    it { should validate_presence_of :user_id }
    
    it "won't save unless it has 1 message" do
      @discussion.messages = []
      @discussion.valid?.should be_false
      @discussion.errors.full_messages.should include("You must include a message")
    end
  end
  
  describe "finds" do
    before do
      @unresponded_disussion = discussions(:one)
      @pending_disussion = discussions(:two)
      @resolved_disussion = discussions(:three)
    end
    
    it "returns only unresolved discussions" do
      Discussion.unresolved.should == [@unresponded_disussion, @pending_disussion]
    end
    
    it "returns only resolved discussions" do
      Discussion.resolved.should == [@resolved_disussion]
    end
    
    it "returns only unresponded discussions" do
      Discussion.unresponded.should == [@unresponded_disussion]
    end
    
    it "returns only pending discussions" do
      Discussion.responded.should == [@pending_disussion]
    end
    
    it "returns only open important discussions" do
      important_discussion = Factory(:discussion, :important => true)
      resolved_important_discussion = Factory(:discussion, :important => true, :resolved => true)
      Discussion.important.should == [important_discussion]
    end
    
  end
  
  describe "instance behavior" do
    
    it "has an initial message" do
      messages = [Factory.build(:message), Factory.build(:message)]
      @discussion.messages = messages
      @discussion.initial_message.should == messages.first
    end
    
    it "has a title" do
      @discussion.initial_message.body = "A really long body about how mad this user is in regard to bugs"
      @discussion.title.should == "A really long body about ho..."
    end
    
    it "has a first received time" do
      first_time = Time.parse('10/10/10 10:00pm')
      last_time = Time.parse('11/11/11 11:00pm')
      first_message = Factory.build(:message, :created_at => first_time)
      last_message = Factory.build(:message, :created_at => last_time)
      @discussion.messages = [first_message, last_message]
      @discussion.times[:first_received].should == first_time
      @discussion.times[:last_replied].should == last_time
    end
  end
  
end
