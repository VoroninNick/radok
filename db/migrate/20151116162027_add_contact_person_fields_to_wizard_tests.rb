class AddContactPersonFieldsToWizardTests < ActiveRecord::Migration
  def change
    change_table :wizard_tests do |t|
      t.string :contact_person_name
      t.string :contact_person_phone
      t.string :contact_person_email
    end
  end
end
