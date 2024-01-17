class Material < ApplicationRecord
  extend FriendlyId
  
  friendly_id :uid, use: [:slugged, :finders]
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
  end
  
  belongs_to :mol
  belongs_to :organization
  belongs_to :account
  has_many :uids, as: :uidable, dependent: :destroy
  has_many :notes, as: :noteble, dependent: :destroy
  has_many :possessions, as: :possessionable, dependent: :destroy
  has_many :rooms, through: :possessions
  has_many :employees, through: :possessions
  belongs_to :type, class_name: "AssetType", optional: true
  
  
  attr_accessor :uid
  attr_reader :all_images

  after_initialize :set_all_images
  before_destroy :permit_desdroy?

  default_scope { order(name: :asc) }

  private 

  def set_all_images
    @all_images = (images + notes.inject([]){|i, n| i + n.images}).sort{|i| i.created_at}.reverse
  end

  def permit_desdroy?
    return if delete_mark
    errors[:base] << "Material don't mark for removing."
    throw :abort
  end
end
