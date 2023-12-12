class Employee < ApplicationRecord

  belongs_to :department, optional: true
  belongs_to :title, optional: true

  default_scope { order(name: :asc) }
end
