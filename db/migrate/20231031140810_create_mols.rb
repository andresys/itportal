class CreateMols < ActiveRecord::Migration[6.1]
  def change
    create_table :mols do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :mols, :code, unique: true
  end
end
