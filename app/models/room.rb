class Room < ApplicationRecord
  belongs_to :location

  after_initialize :set_full_name

  attr_reader :full_name

  default_scope { order(Arel.sql("location_id ASC, substring(name,'[0-9]+')::int ASC")) }

  private

  def set_full_name
    @full_name = "#{location.name}, #{name}"
  end
end
