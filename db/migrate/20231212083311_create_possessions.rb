class CreatePossessions < ActiveRecord::Migration[7.1]
  def change
    create_table :possessions do |t|
      t.references :room, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :possessionable, polymorphic: true, null: false
      t.integer :count, default: 1

      t.timestamps
    end
  end
end