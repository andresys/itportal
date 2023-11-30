class Material < ApplicationRecord
  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]

  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
  end

  belongs_to :mol
  belongs_to :location
  belongs_to :organization
  belongs_to :account
  has_many :uids, as: :uidable, dependent: :destroy
  has_many :notes, as: :noteble, dependent: :destroy

  attr_accessor :uid

  default_scope { order(name: :asc) }
end
