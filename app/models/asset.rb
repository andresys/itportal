class Asset < ApplicationRecord
  extend FriendlyId

  friendly_id :uid, use: [:slugged, :finders]
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
  end
  # belongs_to :item_type
  belongs_to :mol
  belongs_to :organization
  belongs_to :account
  has_many :uids, as: :uidable, dependent: :destroy
  has_many :notes, as: :noteble, dependent: :destroy
  has_many :possessions, as: :possessionable, dependent: :destroy
  has_many :rooms, through: :possessions
  has_many :employees, through: :possessions
  belongs_to :type, class_name: "AssetType", optional: true

  # validates :type, presence: true
  
  attr_accessor :uid
  enum status: { on_balance: 0, out_balance: 1, storage: 2 }
  attr_reader :all_images
  
  after_initialize :set_all_images
  # after_initialize lambda { @uid = uids.last&.uid }
  before_destroy :permit_desdroy?

  def qr_base64_string
    qrcode = RQRCode::QRCode.new("uid: %s" % uid)
    png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 90,
      border_modules: 0,
      module_px_size: 0,
      offset: 0,
      file: nil # path to write
    )
    Base64.strict_encode64(png.to_s)
  end

  default_scope { order(date: :desc, inventory_number: :desc, name: :asc) }

  private

  def set_all_images
    @all_images = (images + notes.inject([]){|i, n| i + n.images}).sort{|i| i.created_at}.reverse
  end

  def set_uid
    uids << Uids.new(uid: SecureRandom.hex(4))
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end

  def permit_desdroy?
    return if delete_mark
    errors[:base] << "Asset don't mark for removing."
    throw :abort
  end
end
