class ImportWizardReportLanguagesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_report_languages;

      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(1,'English','2015-11-13 09:54:18.415169','2015-11-13 09:54:18.415169');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(2,'German','2015-11-13 09:54:25.774579','2015-12-24 13:55:28.468636');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(3,'Polish','2015-11-13 09:54:43.555113','2015-12-24 13:55:45.211583');
      INSERT INTO wizard_report_languages (id, name, created_at, updated_at) VALUES(4,'Russian','2015-11-13 09:54:53.840944','2015-12-24 13:56:02.204917');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_report_languages;
    SQL
  end
end
