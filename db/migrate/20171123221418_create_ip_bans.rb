class CreateIpBans < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_bans do |t|
      t.string :ip

      t.timestamps
    end
  end
end
