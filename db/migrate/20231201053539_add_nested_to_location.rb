class AddNestedToLocation < ActiveRecord::Migration[7.1]
  def change
    remove_index :locations, :code
    remove_column :locations, :code

    add_column :locations, :parent_id, :integer, null: true
    add_column :locations, :lft, :integer, null: false
    add_column :locations, :rgt, :integer, null: false

    add_column :locations, :depth, :integer, null: false, default: 0
    add_column :locations, :children_count, :integer, null: false, default: 0

    add_index :locations, :parent_id
    add_index :locations, :lft
    add_index :locations, :rgt
  end
end
