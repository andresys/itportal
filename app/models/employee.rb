class Employee < ApplicationRecord

  default_scope { order(name: :asc) }
end
