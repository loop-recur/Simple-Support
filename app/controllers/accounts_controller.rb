class AccountsController < ApplicationController

  def show
    @user = current_user
    render(:json => @user)
  end
end
