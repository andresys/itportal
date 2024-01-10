class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :job_id, null: false
      t.integer :job_type, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.jsonb :status

      t.timestamps
    end
  end
end
