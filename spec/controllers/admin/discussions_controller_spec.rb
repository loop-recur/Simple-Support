require 'spec_helper'

module Admin
  
describe DiscussionsController do
  fixtures :discussions, :messages, :users
  render_views 
  
  describe "should require authentication" do
    it "redirects if not authenticated" do
      get :index, :id => 1
      response.should redirect_to(new_user_session_path)
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
