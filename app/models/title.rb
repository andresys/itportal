class Title < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort

  after_find :set_employee_id
  before_save :set_employee_and_organization
  before_destroy :unset_employee

  belongs_to :organization
  belongs_to :department
  has_one :employee

  validates :name, presence: true
  validates :organization, presence: true
  validates :department, presence: true

  attr_accessor :employee_id

  default_scope { order(sort: :asc) }

  private
  
  def set_employee_id
    @employee_id = self.employee&.id
  end

  def set_employee_and_organization
    if @employee_id.present?
      e = Employee.find(@employee_id)
      e.update(organization: self.organization, title: nil)
      self.employee = e
    else
      self.employee = nil
    end
  end

  def unset_employee
    self.employee.update(title: nil)
  end
end
