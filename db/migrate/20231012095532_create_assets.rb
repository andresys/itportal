class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.string :slug
      t.string :name
      t.string :description
      t.float :cost
      t.datetime :date
      t.integer :status
      t.string :inventory_number

      t.string :code
      t.datetime :start_date
      t.integer :useful_life
      t.references :location, foreign_key: true
      t.string :count, :integer
      t.references :account, foreign_key: true
      t.references :organization, foreign_key: true
      t.references :mol, foreign_key: true

      t.timestamps null: false
    end

    add_index :assets, :slug, unique: true
    add_index :assets, [:code, :inventory_number], unique: true
  end
end
