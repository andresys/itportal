class CreateAccountingItems < ActiveRecord::Migration[6.1]
  def change
    create_table :accounting_items do |t|
      t.string :uid, null: false, foreign_key: true
      t.string :slug

      t.string :name
      t.string :description
      
      t.json :options

      t.timestamps null: false
    end
  end
end
