class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :locations, :code, unique: true
  end
end
