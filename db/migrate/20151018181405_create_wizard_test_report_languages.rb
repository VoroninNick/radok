class CreateWizardTestReportLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_test_report_languages do |t|
      t.belongs_to :test, index: true, foreign_key: true
      t.belongs_to :report_language, index: true, foreign_key: true
    end
  end
end
