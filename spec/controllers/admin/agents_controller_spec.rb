require 'spec_helper'

module Admin
  
describe AgentsController do
  fixtures :accounts, :users
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
      @agent = users(:three)
    end
    
    describe "POST /create" do
      context "valid" do
        before do
          User::Admin.any_instance.stubs(:valid?).returns(true)
          @doPost = lambda {post :create, :user_admin => Factory.attributes_for(:admin)}
          @doPost.call
        end

        it { should redirect_to(admin_agents_path) }

        it "creates an admin" do
          @doPost.should change(User::Admin, :count).by(1)
        end
      end

      context "invalid" do
        before do
          User::Admin.any_instance.stubs(:valid?).returns(false)
          @doPost = lambda {post :create, :user_admin => {}}
          @doPost.call
        end

         it { should render_template("admin/agents/new") }
         
         it "doesn't create an admin" do
           @doPost.should change(User::Admin, :count).by(0)
         end
      end
    end
    
    describe "GET /index" do
      before do
        get :index
      end
      
      it { should respond_with :success }
      it { should assign_to :admins }
      it { should render_template :index }
      
      it "only gets agents with the current account's id" do
        agent = Factory(:admin, :account_id => 123)
        get :index
        assigns(:admins).should_not include(agent)
        assigns(:admins).should include(@agent)
      end
    end
    
    describe "GET /edit" do
      before do
        get :edit, :id => 1
      end

      it { should respond_with :success }
      it { should assign_to :admin }
      it { should render_template :edit }
    end
    
    describe "Put to /update" do
      describe "valid" do
        before do
          User::Admin.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @agent.id, :user_admin => {:email => "goo@boo.com"}
        end
      
        it { should assign_to :admin }
        it { should redirect_to(admin_agents_path) }

        it "updates the admin" do
          assigns(:admin).email.should == "goo@boo.com"
        end
      end
      
      describe "invalid" do
        before do
          User::Admin.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @agent.id, :user_admin => {}
        end
        
        it { should render_template(:edit) }
        
        it "doesn't update a admin" do
          assigns(:admin).changed.should be_empty
        end
      end
    end
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @agent.id
      end
      
      it { should redirect_to(admin_agents_path) }
      
      it "destroys record" do
        lambda { @agent.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
