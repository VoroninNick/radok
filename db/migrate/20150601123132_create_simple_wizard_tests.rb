class CreateSimpleWizardTests < ActiveRecord::Migration
  def change
    create_table :simple_wizard_tests do |t|
      t.string :tot__type_of_test
      t.string :top__type_of_product
      t.text :ps__platforms
      t.string :ps__hours
      t.string :pi__project_name
      t.string :pi__project_version
      t.text :pi__project_languages
      t.text :pi__report_languages
      t.string :tp__type_of_testing
      t.text :tp__exploratory_instructions
      t.has_attached_file :tp__test_case_attachment
      t.string :pa__access_instructions_url
      t.has_attached_file :pa__access_instructions_attachment
      t.string :pa__access_user_name
      t.string :pa__access_password
      t.boolean :pa__need_authorization
      t.text :pa__comment

      t.timestamps null: false
    end
  end
end
