class AddImportantToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :important, :boolean
  end
end
