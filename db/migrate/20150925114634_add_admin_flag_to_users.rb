class AddAdminFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
  end
end