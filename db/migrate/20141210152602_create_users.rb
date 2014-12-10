class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :domain, index: true
      t.string :username
      t.string :password

      t.timestamps null: false
    end
    add_foreign_key :users, :domains
  end
end
