class AddAccountIdToDiscussionsAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :integer
    add_column :discussions, :account_id, :integer
  end
end
