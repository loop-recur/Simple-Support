module Admin
  
class MessagesController < Admin::ApplicationController
  
  def create
    @discussion = current_account.discussions.find(params[:discussion_id])
    @message = @discussion.messages.build(params[:message].merge(:user_id => current_admin.id))
    @message.save
    redirect_to(admin_discussion_path(@discussion))
  end
    
  def destroy
    @discussion = current_account.discussions.find(params[:discussion_id])
    @discussion.messages.find(params[:id]).destroy
    redirect_to(admin_discussion_path(@discussion))
  end
  
  def update
    @discussion = current_account.discussions.find(params[:discussion_id])
    @message = @discussion.messages.find(params[:id])
    @message.update_attributes(params[:message])
    redirect_to(admin_discussion_path(@discussion))
  end

  
end

end
