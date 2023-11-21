class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :accounts, :code, unique: true
  end
end
