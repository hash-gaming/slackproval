class CreateBans < ActiveRecord::Migration[5.1]
  def change
    create_table :bans do |t|
      t.string :ban_type
      t.string :ban_value
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
