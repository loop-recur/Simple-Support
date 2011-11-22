module Admin
  
class DiscussionsController < ApplicationController
  
  def index
    @discussions = Discussion.all
  end
  
  def show
    @discussion = Discussion.find(params[:id])
  end
  
  def destroy
    Discussion.find(params[:id]).destroy
    redirect_to discussions_path
  end
  
end

end
