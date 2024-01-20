class Room < ApplicationRecord
  attr_reader :full_name
  
  after_initialize :set_full_name

  belongs_to :location

  validates :name, presence: true

  default_scope { order(Arel.sql("location_id ASC, substring(name,'[0-9]+')::int ASC")) }

  private

  def set_full_name
    @full_name = "#{location.name}, #{name}"
  end
end
