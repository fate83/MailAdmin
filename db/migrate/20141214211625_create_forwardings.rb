class CreateForwardings < ActiveRecord::Migration
  def change
    create_table :forwardings do |t|
      t.references :user, index: true, null: true
      t.references :domain, index: true
      t.string :destination

      t.timestamps null: false
    end
    add_foreign_key :forwardings, :users
    add_foreign_key :forwardings, :domains
  end
end
