class CreateBucketsUsers < ActiveRecord::Migration
  def change
    create_table :buckets_users do |t|
      t.integer :bucket_id, :user_id
      t.timestamps
    end
  end
end
