module Admin
  
class AgentsController < Admin::ApplicationController
  
  def index
    @admins = current_account.admins.paginate(:page => params[:page], :per_page => 15)
  end
  
  def create
    @admin = current_account.admins.build(params[:user_admin])
    @admin.save ? redirect_to(admin_agents_path) : render(:action => :new)
  end
  
  def edit
    @admin = current_account.admins.find(params[:id])
  end
  
  def new
    @admin = current_account.admins.build
  end
  
  def destroy
    current_account.admins.find(params[:id]).destroy
    redirect_to admin_agents_path
  end
  
  def update
    @admin = current_account.admins.find(params[:id])    
    @admin.update_attributes(params[:user_admin]) ? redirect_to(admin_agents_path) : render(:action => :edit)
  end

  
end

end
