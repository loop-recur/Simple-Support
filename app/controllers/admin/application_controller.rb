module Admin
  
class ApplicationController < ::ApplicationController
  before_filter :authenticate_admin!
  helper_method :current_account
  protect_from_forgery 
  
protected
  
  def current_account
    @current_account ||= current_admin.account
  end
  
end

end
