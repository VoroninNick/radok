class AddSavedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :saved_at, :datetime
  end
end
