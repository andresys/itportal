class AddReferencesTo < ActiveRecord::Migration[7.1]
  def change
    add_reference :titles, :organization, foreign_key: { to_table: :organizations }
    add_reference :titles, :department, foreign_key: { to_table: :departments }
  end
end
