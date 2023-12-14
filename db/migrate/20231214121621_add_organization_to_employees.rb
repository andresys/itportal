class AddOrganizationToEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_reference :employees, :department, foreign_key: { to_table: :departments }
    add_reference :employees, :organization, foreign_key: { to_table: :organizations }
  end
end
