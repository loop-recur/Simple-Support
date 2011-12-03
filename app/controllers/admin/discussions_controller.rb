module Admin
  
class DiscussionsController < ApplicationController
  
  def index
    discussions = DiscussionFinder.new(params, current_account).discussions
    @discussions = discussions.paginate(:page => params[:page], :per_page => 15)
  end
  
  def create
    @user = User::TicketHolder::Factory.create(params[:user].merge(:account_id => current_account.id))
    params[:discussion].merge!(:user_id => @user.id, :account_id => current_account.id)
    params[:discussion][:messages_attributes].first.merge!(:user_id => @user.id)
  
    @discussion = Discussion.new(params[:discussion])
    @discussion.save ? redirect_to(admin_discussion_path(@discussion)) : render(:action => :new)
  end
  
  def new
    @discussion = Discussion.new
  end
  
  def show
    @discussion = current_account.discussions.find(params[:id])
  end
  
  def update
    @discussion = current_account.discussions.find(params[:id])    
    @discussion.update_attributes(params[:discussion])
    flash[:error] = @discussion.errors.full_messages.join(", ") unless @discussion.valid?
    redirect_to admin_discussion_path(@discussion)
  end
  
  def destroy
    current_account.discussions.find(params[:id]).destroy
    redirect_to admin_discussions_path
  end
end

end
