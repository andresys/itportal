class Job < ApplicationRecord
  enum job_type: { import_assets_from_1c: 0, import_materials_from_1c: 1, import_employees: 2 }
  has_many :job_histories, dependent: :destroy

  default_scope { order(created_at: :desc) }
  scope :with_number_of_stories, -> { select("jobs.*, (select count(*) from job_histories where job_id = jobs.id and action = 'remove') as rhc") }
end
