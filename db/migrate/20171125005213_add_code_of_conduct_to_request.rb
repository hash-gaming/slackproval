class AddCodeOfConductToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :code_of_conduct, :boolean, default: false
  end
end
