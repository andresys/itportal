class CreateJobHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :job_histories do |t|
      t.references :job, null: false
      t.integer :action
      t.references :record, null: false, polymorphic: true
      t.jsonb :values

      t.timestamps
    end
  end
end
