require 'spec_helper'

module Admin
  
describe TicketHoldersController do
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
      @ticket_holder = users(:two)
    end
    
    describe "POST /create" do
      context "valid" do
        before do
          User::TicketHolder.any_instance.stubs(:valid?).returns(true)
          @doPost = lambda {post :create, :user_ticket_holder => Factory.attributes_for(:ticket_holder)}
          @doPost.call
        end

        it { should redirect_to(admin_ticket_holders_path) }

        it "creates an admin" do
          @doPost.should change(User::TicketHolder, :count).by(1)
        end
      end

      context "invalid" do
        before do
          User::TicketHolder.any_instance.stubs(:valid?).returns(false)
          @doPost = lambda {post :create, :user_ticket_holder => {}}
          @doPost.call
        end

         it { should render_template("admin/ticket_holders/new") }
         
         it "doesn't create an admin" do
           @doPost.should change(User::TicketHolder, :count).by(0)
         end
      end
    end
    
    describe "GET /index" do
      before do
        get :index
      end
      
      it { should respond_with :success }
      it { should assign_to :ticket_holders }
      it { should render_template :index }
      
      it "only gets ticket_holders with the current account's id" do
        ticket_holder = Factory(:ticket_holder, :account_id => 123)
        get :index
        assigns(:ticket_holders).should_not include(ticket_holder)
        assigns(:ticket_holders).should include(@ticket_holder)
      end
    end
    
    describe "GET /edit" do
      before do
        get :edit, :id => @ticket_holder.id
      end

      it { should respond_with :success }
      it { should assign_to :ticket_holder }
      it { should render_template :edit }
    end
    
    describe "Put to /update" do
      describe "valid" do
        before do
          User::TicketHolder.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @ticket_holder.id, :user_ticket_holder => {:email => "goo@boo.com"}
        end
      
        it { should assign_to :ticket_holder }
        it { should redirect_to(admin_ticket_holders_path) }

        it "updates the ticket_holder" do
          assigns(:ticket_holder).email.should == "goo@boo.com"
        end
      end
      
      describe "invalid" do
        before do
          User::TicketHolder.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @ticket_holder.id, :user_ticket_holder => {}
        end
        
        it { should render_template(:edit) }
        
        it "doesn't update a ticket_holder" do
          assigns(:ticket_holder).changed.should be_empty
        end
      end
    end
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @ticket_holder.id
      end
      
      it { should redirect_to(admin_ticket_holders_path) }
      
      it "destroys record" do
        lambda { @ticket_holder.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
