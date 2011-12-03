require 'spec_helper'

module Admin
  
describe DiscussionsController do
  fixtures :accounts, :buckets, :discussions, :messages, :users
  render_views 
  
  describe "should require authentication" do
    it "redirects if not authenticated" do
      get :index
      response.should redirect_to(new_admin_session_path)
    end
  end
  
  describe "Authenticated examples" do
    before do
      @user = users(:one)
      sign_in(@user)
      @discussion = discussions(:one)
    end
    
    describe "POST /create" do
      context "valid" do
        before do
          Discussion.any_instance.stubs(:valid?).returns(true)
          user_attrs = {:name => "Bob", :email => "bob@hotmail.com"}
          discussion_attrs = {:messages_attributes => [{:body => "yo man!"}]}
          @doPost = lambda {post :create, :discussion => discussion_attrs, :user => user_attrs, :account_id => 1}
          @doPost.call
        end
    
        it { should redirect_to(admin_discussion_path(assigns(:discussion))) }
      
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
          @doPost = lambda{ post :create, :discussion => {:messages_attributes => [{}]}, :user => {} }
          @doPost.call
        end
        
        it { should render_template :new }
        
        it "doesn't create a discussion" do
          @doPost.should change(Discussion, :count).by(0)
        end
      end
    end
    
    describe "GET /new" do
      before do
        get :new
      end

      it { should respond_with :success }
      it { should assign_to :discussion }
      it { should render_template :new }
    end
    
    describe "GET /index" do
      before do
        @pending_discussion = discussions(:two)
        @resolved_discussion = discussions(:three)
        get :index
      end
      
      it { should respond_with :success }
      it { should assign_to :discussions }
      it { should render_template :index }
      
      it "only gets open discussions with the current account's id" do
        discussion = Factory(:discussion, :account_id => 123)
        get :index
        assigns(:discussions).should == [@discussion, @pending_discussion]
      end
      
      context "a queue" do
        before do
          @other_discussion = Factory(:discussion, :account_id => 1, :bucket_id => nil, :important => true)
          @bucket = buckets(:one)
        end
      
        it "only gets discussions with the current queue" do
          get :index, :queue => {:id => 1}
          assigns(:discussions).should == [@discussion]
        end
        
        it "gets all discussions when the queue is zero" do
          get :index, :queue => {:id => 0}
          assigns(:discussions).should == [@discussion, @pending_discussion, @other_discussion]
        end
        
        context "and a status" do
          it "only gets new discussions" do
            get :index, :status => :new
            assigns(:discussions).should == [@discussion]
          end
          
          it "only gets important discussions" do
            get :index, :status => :important
            assigns(:discussions).should == [@other_discussion]
          end
          
          it "only gets closed discussions" do
            get :index, :status => :closed
            assigns(:discussions).should == [@resolved_discussion]
          end
          
          it "only gets closed in a certain bucket" do
            @discussion.update_attribute(:resolved, true)
            get :index, :queue => {:id => 1}, :status => :closed
            assigns(:discussions).should == [@discussion]
          end
          
          it "only gets pending discussions" do
            get :index, :status => :pending
            assigns(:discussions).should == [@other_discussion]
          end
        end
      end
    end

    describe "GET /show" do
      before do
        get :show, :id => @discussion.id
      end

      it { should respond_with :success }
      it { should assign_to :discussion }
      it { should render_template :show }
    end
    
    describe "Put to /update" do
      describe "valid" do
        before do
          Discussion.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @discussion.id, :discussion => {:resolved => "1"}
        end
      
        it { should assign_to :discussion }
        it { should redirect_to(admin_discussion_path(@discussion)) }

        it "updates the discussion" do
          assigns(:discussion).resolved?.should be_true
        end
      end
      
      describe "invalid" do
        before do
          Discussion.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @discussion.id, :discussion => {}
        end
        
        it { should redirect_to(admin_discussion_path(@discussion)) }
        it { should set_the_flash }
        
        it "doesn't update a discussion" do
          assigns(:discussion).changed.should be_empty
        end
      end
    end
    
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @discussion.id
      end
      
      it { should redirect_to(admin_discussions_path) }
      
      it "destroys record" do
        lambda { @discussion.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
