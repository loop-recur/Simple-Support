class DiscussionsController < ApplicationController
  
  def create
    @user = User::Factory.create(params[:user])
    
    params[:discussion].merge!(:user_id => @user.id)
    params[:discussion][:messages_attributes].first.merge!(:user_id => @user.id)
    
    @discussion = Discussion.create(params[:discussion])
    
    appender = ParamAppender.new(params[:deploy_url])
    url = appender.append(:error => @discussion.new_record?, :anchor => "simple_support")
    redirect_to(url)
  end
  

  def index
    @discussion = Discussion.new
  end  
end
