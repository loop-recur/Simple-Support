require 'spec_helper'

module Admin
  
describe MessagesController do
  fixtures :accounts, :messages, :discussions, :users
  render_views
  
  describe "should require authentication" do
    it "redirects if not authenticated" do
      post :create, :message => {}, :discussion_id => 1
      response.should redirect_to(new_admin_session_path)
    end
  end
  
  describe "Authenticated examples" do
    before do
      @user = users(:one)
      sign_in(@user)
      @message = messages(:one)
      @discussion = discussions(:one)
    end
    
    describe "POST /create" do
      context "valid" do
        before do
          Message.any_instance.stubs(:valid?).returns(true)
          @doPost = lambda {post :create, :message => Factory.attributes_for(:message), :discussion_id => @discussion.id}
          @doPost.call
        end

        it { should redirect_to(admin_discussion_path(@discussion)) }

        it "creates a message" do
          @doPost.should change(Message, :count).by(1)
        end
        
        it "assigns that message to the discussion" do
          @discussion.reload.latest_message.should == assigns(:message)
        end
        
        it "assigns the current user to the message" do
          assigns(:message).user.should == @user
        end
      end

      context "invalid" do
        before do
          Message.any_instance.stubs(:valid?).returns(false)
          @doPost = lambda {post :create, :message => {}, :discussion_id => @discussion.id}
          @doPost.call
        end
        
        it { should redirect_to(admin_discussion_path(@discussion)) }
         
       it "doesn't create a message" do
         @doPost.should change(Message, :count).by(0)
       end
      end
    end
    
    describe "Put to /update" do
      describe "valid" do
        before do
          Message.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @message.id, :message => {:body => "blah"}, :discussion_id => @discussion.id
        end
      
        it { should assign_to :message }
        it { should redirect_to(admin_discussion_path(@discussion)) }

        it "updates the admin" do
          assigns(:message).body.should == "blah"
        end
      end
      
      describe "invalid" do
        before do
          Message.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @message.id, :message => {}, :discussion_id => @discussion.id
        end
        
        it { should redirect_to(admin_discussion_path(@discussion)) }
        
        it "doesn't update a admin" do
          assigns(:message).changed.should be_empty
        end
      end
    end
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @message.id, :discussion_id => @discussion.id
      end
      
      it { should redirect_to(admin_discussion_path(@discussion)) }
      
      it "destroys record" do
        lambda { @message.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
