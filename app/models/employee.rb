class EmployeeValidator < ActiveModel::Validator
  def validate(record)
    if record.organization && record.title && record.organization != record.title.organization
      record.errors.add :base, "The Title does not exist in the selected organization"
    end
  end
end

class Employee < ApplicationRecord
  resourcify
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, :resize_to_fill => [200,200]
    attachable.variant :icon, :resize_to_fill => [34,34]
  end

  before_save :set_organization

  belongs_to :organization, optional: true
  belongs_to :title, optional: true

  validates :name, presence: true
  validates_with EmployeeValidator

  default_scope { order(name: :asc) }

private

  def set_organization
    self.organization = self.title.organization if self.title
  end
end
