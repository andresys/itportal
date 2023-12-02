class CreateTitles < ActiveRecord::Migration[7.1]
  def change
    create_table :titles do |t|
      t.string :name
      t.integer :sort

      t.timestamps
    end

    add_reference :employees, :title, foreign_key: { to_table: :titles }
  end
end
