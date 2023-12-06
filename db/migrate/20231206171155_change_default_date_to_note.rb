class ChangeDefaultDateToNote < ActiveRecord::Migration[7.1]
  def up
    change_column :notes, :date, :datetime, default: nil, null: false
  end
end
