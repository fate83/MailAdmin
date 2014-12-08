class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.references :admin, index: true

      t.timestamps null: false
    end
    add_foreign_key :domains, :admins
  end
end
