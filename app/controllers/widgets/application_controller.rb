module Widgets
  
class ApplicationController < ::ApplicationController
  layout "widgets"
  
  def route
    redirect_to Router.path(params)
  end  
end

end
