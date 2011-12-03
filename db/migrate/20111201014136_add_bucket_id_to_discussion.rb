class AddBucketIdToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :bucket_id, :integer
  end
end
