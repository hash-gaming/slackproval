class AddDeletedAtToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :deleted_at, :datetime
    add_index :requests, :deleted_at
  end
end
