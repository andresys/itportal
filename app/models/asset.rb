class Asset < ApplicationRecord
  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]

  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
  end
  # belongs_to :item_type
  belongs_to :mol
  belongs_to :location
  belongs_to :employee
  belongs_to :organization
  belongs_to :account
  has_many :uids, as: :uidable, dependent: :destroy
  has_many :notes, as: :noteble, dependent: :destroy

  attr_accessor :uid
  enum status: { on_balance: 0, out_balance: 1, storage: 2 }

  # after_initialize lambda { @uid = uids.last&.uid }

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

  default_scope { order(date: :desc, name: :asc, inventory_number: :desc) }

private
  def set_uid
    uids << Uids.new(uid: SecureRandom.hex(4))
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
