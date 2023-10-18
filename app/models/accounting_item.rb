class AccountingItem < ApplicationRecord
  extend FriendlyId
  friendly_id :uid, use: [:slugged, :finders]

  attr_accessor :inventory_number, :total, :date, :status

  # belongs_to :item_type
  # belongs_to :item_mol

  before_create :set_uid
  before_validation :set_options
  after_initialize :init_options

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
    @status = [0,1,2].sample
    @total = rand(0..10**6)
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
