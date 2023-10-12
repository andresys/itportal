class CreateAssetTable < ActiveRecord::Migration[6.1]
  def change
    create_table :asset_tables do |t|
      t.string :uid, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.float :total
      t.datetime :date
      t.integer :status

      t.timestamps null: false
    end
    add_index :asset_tables, :uid, unique: true
  end
end
