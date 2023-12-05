class AddReferencesDepartmentToOrganization < ActiveRecord::Migration[7.1]
  def change
    add_reference :departments, :organization, foreign_key: { to_table: :organizations }
  end
end
