class AddDeleteMark < ActiveRecord::Migration[7.1]
  def change
    add_column :assets, :delete_mark, :boolean, null: false, default: false
    add_column :materials, :delete_mark, :boolean, null: false, default: false
    add_column :employees, :delete_mark, :boolean, null: false, default: false
  end
end
