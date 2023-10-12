class Asset < ApplicationRecord
  self.table_name="accounting_items"

  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]

  attr_accessor :inventory_number, :total, :date, :status

  # belongs_to :item_type
  # belongs_to :item_mol

  before_create :set_uid
  before_validation :set_options
  after_initialize :init_options

  STATUSES = [
    {label: "На балансе", color: "bg-success"},
    {label: "На хранении", color: "bg-warning"},
    {label: "Списанные", color: "bg-danger"}
  ]

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

  def method_missing(m, *args, &block)

  end

  def [](name)
    public_send(name)
  end

private
  def set_uid
    self.slug = self.uid = SecureRandom.hex(4)
  end

  def set_options
    self.options = { inventory_number: @inventory_number }
  end

  def init_options
    @inventory_number ||= options && options['inventory_number']
    @date = rand((DateTime.now - 3.year)..DateTime.now)
    @status = STATUSES.sample
    @total = rand(0..10**6)
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
