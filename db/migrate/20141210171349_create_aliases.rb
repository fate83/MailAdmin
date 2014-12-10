class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.string  :user_source
      t.integer :domain_source_id
      t.integer :user_destination_id
      t.integer :domain_destination_id

      t.timestamps null: false
    end
  end
end
