class Asset < ApplicationRecord
  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]

  has_many_attached :images
  # belongs_to :item_type
  # belongs_to :item_mol

  before_create :set_uid

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

  default_scope { order(:created_at) }

private
  def set_uid
    self.slug = self.uid = SecureRandom.hex(4)
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
