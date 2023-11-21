class AddFieldsToAsset < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :code, :string
    add_column :assets, :start_date, :datetime
    add_column :assets, :useful_life, :integer
    add_reference  :assets, :location, foreign_key: true
    add_column :assets, :count, :integer
    add_reference  :assets, :account, foreign_key: true
    add_reference  :assets, :organization, foreign_key: true
    add_reference  :assets, :mol, foreign_key: true

    add_index :assets, [:code, :inventory_number], unique: true
  end
end