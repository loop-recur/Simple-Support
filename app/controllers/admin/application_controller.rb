module Admin
  
class ApplicationController < ::ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery 
end

end
