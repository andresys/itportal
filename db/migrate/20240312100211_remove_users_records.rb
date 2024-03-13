class RemoveUsersRecords < ActiveRecord::Migration[7.1]
  def self.up
    User.destroy_all
  end
end
