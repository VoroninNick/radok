class ImportWizardSettings < ActiveRecord::Migration
  def up
  	execute(<<-SQL)
      DELETE FROM wizard_settings;
      INSERT INTO wizard_settings (id, hour_price, created_at, updated_at) VALUES(1, 29, '2016-05-04 15:03:29.521831','2016-05-04 15:03:29.335739');
    SQL
  end

  def down
  	execute(<<-SQL)
      DELETE FROM wizard_settings;
    SQL
  end

end
