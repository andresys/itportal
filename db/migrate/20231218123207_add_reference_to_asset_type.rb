class AddReferenceToAssetType < ActiveRecord::Migration[7.1]
  def change
    add_reference :assets, :type, default: nil, foreign_key: { to_table: :asset_types }
    add_reference :materials, :type, default: nil, foreign_key: { to_table: :asset_types }
  end
end
