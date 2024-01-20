class AssetType < ApplicationRecord
  acts_as_nested_set

  validates :name, presence: true
  
  default_scope { order(lft: :asc) }
end
