class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.string :uid, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.float :total
      t.datetime :date
      t.integer :status
      t.string :inventory_number

      t.timestamps null: false
    end
    add_index :assets, :uid, unique: true
  end
end
