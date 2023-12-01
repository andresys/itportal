class AddCodeToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :code, :integer
    add_index :employees, :code, :unique => true
  end
end
