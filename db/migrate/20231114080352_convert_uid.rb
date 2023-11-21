class ConvertUid < ActiveRecord::Migration[7.0]
  def up
    Uid.import Asset.where.not(uid: nil).map { |asset| Uid.new(uid: asset.uid, uidable_id: asset.id, uidable_type: 'Asset') }
    
    remove_index :assets, :uid
    remove_column :assets, :uid
  end

  def down
    add_column :assets, :uid, :string, null: false, foreign_key: true
    add_index :assets, :uid, unique: true

    uids = Uid.where(uidable_type: 'Asset').order(updated_at: :asc).group_by(&:uidable_id).transform_values(&:first).values
    uids.each do |uid|
      asset = Asset.find(uid.uidable_id)
      asset.update(uid: uid.uid)
    end
  end
end
