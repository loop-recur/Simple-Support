require 'spec_helper'

describe LinksHelper do
  before do
    @discussion = Factory.build(:discussion, :id => 1, :resolved => true)
  end
 
 it "returns a button that does the negative action" do
   link = toggle_action("Open", "Close", @discussion, :resolved)
   link.should == button_to("Close", admin_discussion_path(@discussion.id, :discussion => {:resolved => false}), :method => :put)
 end
 
 it "returns a button that does the positive action" do
   @discussion.resolved = false
   link = toggle_action("Open", "Close", @discussion, :resolved)
   link.should == button_to("Open", admin_discussion_path(@discussion.id, :discussion => {:resolved => true}), :method => :put)
 end
 
end
