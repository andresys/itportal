class Possession < ApplicationRecord
  resourcify
  
  belongs_to :room, optional: true
  belongs_to :employee, optional: true
  belongs_to :possessionable, polymorphic: true

  validate :room_or_employee
  
private
  def room_or_employee
    return unless room.blank? && employee.blank?
    errors.add(:base, I18n.t('activerecord.errors.messages.employee_or_location_must_not_be_empty'))
  end
end
