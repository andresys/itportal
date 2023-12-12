class RemoveDeprecatedFieldsFromLocation < ActiveRecord::Migration[7.1]
  def up
    remove_index :locations, :lft
    remove_index :locations, :parent_id
    remove_index :locations, :rgt

    remove_column :locations, :parent_id
    remove_column :locations, :lft
    remove_column :locations, :rgt
    remove_column :locations, :depth
    remove_column :locations, :children_count
  end
end
