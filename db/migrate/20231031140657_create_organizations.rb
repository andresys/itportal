class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :organizations, :code, unique: true
  end
end
