class JobHistory < ApplicationRecord
  belongs_to :job
  enum action: { add: 0, remove: 1, change: 2 }
  belongs_to :record, polymorphic: true
end
