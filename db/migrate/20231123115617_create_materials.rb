class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :slug
      t.string :name
      t.string :description
      t.float :cost

      t.string :code
      t.integer :count
      t.references :location, foreign_key: true
      t.references :account, foreign_key: true
      t.references :organization, foreign_key: true
      t.references :mol, foreign_key: true

      t.timestamps null: false
    end

    add_index :materials, :slug, unique: true
    add_index :materials, :code, unique: true
  end
end
