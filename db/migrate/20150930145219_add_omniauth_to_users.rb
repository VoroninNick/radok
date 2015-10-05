class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :provider #, :null => false
      t.string :uid #, :null => false
    end

    #
    #
    # add_column :users, :last_login, :datetime
    # add_column :users, :total_logins, :integer, :null => false, :default => 1
    #
    # Account.reset_column_information
    #
    # Account.all.each do |account|
    #   account.last_login = account.created_at
    #   account.save!
    # end
    #
    # change_column :accounts, :last_login, :datetime, :null => false
  end
end
