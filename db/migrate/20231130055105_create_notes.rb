class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.datetime :date, :default => DateTime.now
      t.string :text, null: false
      t.json :details
      t.references :noteble, polymorphic: true, null: false

      t.timestamps
    end
  end
end
