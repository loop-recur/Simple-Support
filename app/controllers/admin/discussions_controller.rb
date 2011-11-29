module Admin
  
class DiscussionsController < ApplicationController
  
  def index
    @discussions = current_account.discussions.paginate(:page => params[:page], :per_page => 15)
  end
  
  def show
    @discussion = current_account.discussions.find(params[:id])
  end
  
  def destroy
    current_account.discussions.find(params[:id]).destroy
    redirect_to discussions_path
  end
  
end

end
