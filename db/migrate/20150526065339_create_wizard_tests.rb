class CreateWizardTests < ActiveRecord::Migration
  def change
    create_table :wizard_tests do |t|
      t.string :state
      t.float :percent_completed
      #t.string :steps_json
      t.integer :hours_per_tester

      t.string :project_name
      t.string :project_version
      t.string :project_languages
      t.string :report_languages

      t.string :methodology_type
      t.text :exploratory_description
      t.string :project_url
      t.boolean :authentication_required
      t.string :auth_login
      t.string :auth_password
      t.text :comment

      t.timestamps null: false
    end
  end
end
