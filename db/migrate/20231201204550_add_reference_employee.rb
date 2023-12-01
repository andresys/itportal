class AddReferenceEmployee < ActiveRecord::Migration[7.1]
  def change
    add_reference :assets, :employee, foreign_key: { to_table: :employees }
    add_reference :materials, :employee, foreign_key: { to_table: :employees }
  end
end
