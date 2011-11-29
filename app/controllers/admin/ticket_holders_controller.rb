module Admin
  
class TicketHoldersController < Admin::ApplicationController
  
  def index
    @ticket_holders = current_account.ticket_holders.paginate(:page => params[:page], :per_page => 15)
  end
  
  def create
    @ticket_holder = current_account.ticket_holders.build(params[:user_ticket_holder])
    @ticket_holder.save ? redirect_to(admin_ticket_holders_path) : render(:action => :new)
  end
  
  def edit
    @ticket_holder = current_account.ticket_holders.find(params[:id])
  end
  
  def new
    @ticket_holder = current_account.ticket_holders.build
  end
  
  def destroy
    current_account.ticket_holders.find(params[:id]).destroy
    redirect_to admin_ticket_holders_path
  end
  
  def update
    @ticket_holder = current_account.ticket_holders.find(params[:id])    
    @ticket_holder.update_attributes(params[:user_ticket_holder]) ? redirect_to(admin_ticket_holders_path) : render(:action => :edit)
  end
  
  
end

end
