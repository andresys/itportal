class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    drop_table :people if table_exists?(:people)

    create_table :departments do |t|
      t.string :name

      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end

    add_reference :employees, :department, foreign_key: { to_table: :departments }
  end
end
