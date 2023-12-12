class RemoveDeprecatedFieldsFromAssetAndMoterial < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :assets, :employees
    remove_foreign_key :assets, :locations
    remove_foreign_key :materials, :employees
    remove_foreign_key :materials, :locations

    remove_index :assets, :employee_id
    remove_index :assets, :location_id
    remove_index :materials, :employee_id
    remove_index :materials, :location_id

    remove_column :assets, :employee_id
    remove_column :assets, :location_id
    remove_column :materials, :employee_id
    remove_column :materials, :location_id
  end
end
