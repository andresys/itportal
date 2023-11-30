class ConvertNoteAndRemoveLocation < ActiveRecord::Migration[7.1]
  def up
    Asset.where.not(description: nil).each do |asset|
      Note.create(noteble: asset, text: asset.description)
    end

    Material.where.not(description: nil).each do |material|
      Note.create(noteble: material, text: material.description)
    end

    Asset.update_all location_id: nil, description: nil
    Material.update_all location_id: nil, description: nil
    Location.delete_all
  end
end
