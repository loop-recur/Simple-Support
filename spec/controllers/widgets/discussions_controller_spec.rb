require 'spec_helper'

module Widgets
    
describe DiscussionsController do
  fixtures :discussions, :users
  
  before do
    @discussion = discussions(:one)
  end
  
  describe "POST /create" do
    context "valid" do
      before do
        Discussion.any_instance.stubs(:valid?).returns(true)
        user_attrs = {:name => "Bob", :email => "bob@hotmail.com"}
        discussion_attrs = {:messages_attributes => [{:body => "yo man!"}]}
        @doPost = lambda {post :create, :discussion => discussion_attrs, :user => user_attrs, :account_id => 1, :deploy_url => "/toast"}
        @doPost.call
      end
    
      it { should redirect_to("/toast?error=false#simple_support") }
      
      it "creats a discussion" do
        @doPost.should change(Discussion, :count).by(1)
      end
      
      it "doesn't create a second user" do
        @doPost.should change(User, :count).by(0)
      end
      
      it "creats a discussion with user" do
        assigns(:discussion).user.name.should == "Bob"
      end
    
      it "creats a discussion with messages that have the same user" do
        assigns(:discussion).initial_message.body.should == "yo man!"
        assigns(:discussion).initial_message.user.name.should == "Bob"
      end
    end
  
    context "invalid" do
      before do
        Discussion.any_instance.stubs(:valid?).returns(false)
        post :create, :discussion => {:messages_attributes => [{}]}, :user => {}, :deploy_url => "/toast"
      end
       
       it { should redirect_to("/toast?error=true#simple_support") }
    end
  end
  
  describe "GET /index" do
    before do
      get :index
    end
    
    it { should assign_to :discussion }
    it { should respond_with :success }
    it { should render_template :index }    
  end
end

end
