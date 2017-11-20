class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :email
      t.text :reason
      t.boolean :approved
      t.boolean :denied

      t.timestamps
    end
  end
end
