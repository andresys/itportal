class Material < ApplicationRecord
  extend FriendlyId

  after_initialize :set_all_images

  friendly_id :uid, use: [:slugged, :finders]

  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
  end

  belongs_to :mol
  belongs_to :location, optional: true
  belongs_to :employee, optional: true
  belongs_to :organization
  belongs_to :account
  has_many :uids, as: :uidable, dependent: :destroy
  has_many :notes, as: :noteble, dependent: :destroy

  attr_accessor :uid
  attr_reader :all_images

  default_scope { order(name: :asc) }

  private 

  def set_all_images
    @all_images = (images + notes.inject([]){|i, n| i + n.images}).sort{|i| i.created_at}
  end
end
