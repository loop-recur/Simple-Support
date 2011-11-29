require 'spec_helper'

module Admin
  
describe DiscussionsController do
  fixtures :accounts, :discussions, :messages, :users
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
    
    describe "GET /index" do
      before do
        get :index
      end
      
      it { should respond_with :success }
      it { should assign_to :discussions }
      it { should render_template :index }
      
      it "only gets discussions with the current account's id" do
        discussion = Factory(:discussion, :account_id => 123)
        get :index
        assigns(:discussions).should == [@discussion]
      end
    end

    describe "GET /show" do
      before do
        get :show, :id => 1
      end

      it { should respond_with :success }
      it { should assign_to :discussion }
      it { should render_template :show }
    end
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @discussion.id
      end
      
      it { should redirect_to(discussions_path) }
      
      it "destroys record" do
        lambda { @discussion.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
