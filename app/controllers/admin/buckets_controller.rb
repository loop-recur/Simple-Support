module Admin
  
class BucketsController < Admin::ApplicationController
  
  def create
    @bucket = current_account.buckets.build(params[:bucket])
    @bucket.save ? redirect_to(admin_discussions_path) : render(:action => :new)
  end
  
  def edit
    @bucket = current_account.buckets.find(params[:id])
  end
  
  def new
    @bucket = current_account.buckets.build
  end
  
  def destroy
    current_account.buckets.find(params[:id]).destroy
    redirect_to admin_discussions_path
  end
  
  def update
    @bucket = current_account.buckets.find(params[:id])    
    @bucket.update_attributes(params[:bucket]) ? redirect_to(admin_discussions_path) : render(:action => :edit)
  end
  
end

end
