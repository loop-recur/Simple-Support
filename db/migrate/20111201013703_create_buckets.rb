class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :account_id
      t.timestamps
    end
  end
end
