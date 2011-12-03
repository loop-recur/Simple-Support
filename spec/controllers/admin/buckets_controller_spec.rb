require 'spec_helper'

module Admin
  
describe BucketsController do
  fixtures :accounts, :buckets, :users
  render_views 
  
  describe "should require authentication" do
    it "redirects if not authenticated" do
      get :edit, :id => 1
      response.should redirect_to(new_admin_session_path)
    end
  end
  
  describe "Authenticated examples" do
    before do
      @user = users(:one)
      sign_in(@user)
      @bucket = buckets(:one)
    end
    
    describe "POST /create" do
      context "valid" do
        before do
          Bucket.any_instance.stubs(:valid?).returns(true)
          @doPost = lambda {post :create, :bucket => Factory.attributes_for(:bucket)}
          @doPost.call
        end

        it { should redirect_to(admin_discussions_path) }

        it "creates a bucket" do
          @doPost.should change(Bucket, :count).by(1)
        end
      end

      context "invalid" do
        before do
          Bucket.any_instance.stubs(:valid?).returns(false)
          @doPost = lambda {post :create, :bucket => {}}
          @doPost.call
        end

         it { should render_template("admin/buckets/new") }
         
         it "doesn't create a bucket" do
           @doPost.should change(Bucket, :count).by(0)
         end
      end
    end
    
    describe "GET /new" do
      before do
        get :new
      end

      it { should respond_with :success }
      it { should assign_to :bucket }
      it { should render_template :new }
    end
    
    describe "GET /edit" do
      before do
        get :edit, :id => @bucket.id
      end

      it { should respond_with :success }
      it { should assign_to :bucket }
      it { should render_template :edit }
    end
    
    describe "Put to /update" do
      describe "valid" do
        before do
          Bucket.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @bucket.id, :bucket => {:name => "goo"}
        end
      
        it { should assign_to :bucket }
        it { should redirect_to(admin_discussions_path) }

        it "updates the bucket" do
          assigns(:bucket).name.should == "goo"
        end
      end
      
      describe "invalid" do
        before do
          Bucket.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @bucket.id, :bucket => {}
        end
        
        it { should render_template(:edit) }
        
        it "doesn't update a bucket" do
          assigns(:bucket).changed.should be_empty
        end
      end
    end
    
    describe "DELETE /destroy" do
      before do
        delete :destroy, :id => @bucket.id
      end
      
      it { should redirect_to(admin_discussions_path) }
      
      it "destroys record" do
        lambda { @bucket.reload }.should raise_error(::ActiveRecord::RecordNotFound)
      end
    end
    
  end
end

end
