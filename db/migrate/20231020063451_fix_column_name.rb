class FixColumnName < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :assets, :total, :cost
  end

  def self.down
    # rename back if you need or do something else or do nothing
    # rename_column :assets, :cost, :total
  end
end
