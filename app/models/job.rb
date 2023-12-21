class Job < ApplicationRecord
  enum job_type: { import_assets_from_1c: 0, import_materials_from_1c: 1, import_employees: 2 }

  default_scope { order(created_at: :desc) }
end
