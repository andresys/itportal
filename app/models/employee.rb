class Employee < ApplicationRecord

  belongs_to :department
  belongs_to :title

  default_scope { order(name: :asc) }
end
