class AddAgeMustBeOverToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :age_must_be_over, :boolean, default: false
  end
end
