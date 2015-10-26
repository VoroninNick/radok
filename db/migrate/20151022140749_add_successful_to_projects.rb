class AddSuccessfulToProjects < ActiveRecord::Migration
  def change
    add_column :wizard_tests, :successful, :boolean
  end
end
