class CreateUids < ActiveRecord::Migration[7.0]
  def change
    create_table :uids do |t|
      t.string :uid, null: false, foreign_key: true
      t.references :uidable, polymorphic: true, null: false

      t.timestamps
    end
    add_index :uids, :uid, unique: true
  end
end
