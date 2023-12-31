class CreateAssetTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :asset_types do |t|
      t.string :name

      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end
  end
end
