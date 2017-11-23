class CreateDomainBans < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_bans do |t|
      t.string :domain

      t.timestamps
    end
  end
end
