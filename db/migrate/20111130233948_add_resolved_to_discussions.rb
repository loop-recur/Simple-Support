class AddResolvedToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :resolved, :boolean
  end
end
