class CreateWizardReportLanguages < ActiveRecord::Migration
  def change
    create_table :wizard_report_languages do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
