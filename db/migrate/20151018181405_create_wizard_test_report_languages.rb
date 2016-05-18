class CreateWizardTestReportLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_test_report_languages do |t|
      t.integer :test_id, index: true, foreign_key: true
      t.integer :report_language_id, index: true, foreign_key: true
    end
  end
end
