class AssetType < ApplicationRecord
  acts_as_nested_set

  default_scope { order(lft: :asc) }
end
