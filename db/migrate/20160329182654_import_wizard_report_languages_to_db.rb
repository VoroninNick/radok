class ImportWizardReportLanguagesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_report_languages;

      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(1,'English','2015-11-13 09:54:18.415169','2015-11-13 09:54:18.415169');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(2,'French','2015-11-13 09:54:25.774579','2015-11-13 09:54:25.774579');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(3,'Spanish','2015-11-13 09:54:43.555113','2015-11-13 09:54:43.555113');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(4,'Dutch','2015-11-13 09:54:53.840944','2015-11-13 09:54:53.840944');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(5,'Portuguese','2015-11-13 09:55:04.693434','2015-11-13 09:55:04.693434');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_report_languages;
    SQL
  end
end
