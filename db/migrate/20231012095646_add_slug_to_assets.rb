class AddSlugToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :slug, :string
    add_index :assets, :slug, unique: true
  end
end
