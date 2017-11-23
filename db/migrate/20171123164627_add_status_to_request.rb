class AddStatusToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :string, default: 'pending'
    remove_column :requests, :approved, :boolean
    remove_column :requests, :denied, :boolean
  end
end
