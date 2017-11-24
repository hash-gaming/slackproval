class AddIPtoRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :ip, :string
  end
end
