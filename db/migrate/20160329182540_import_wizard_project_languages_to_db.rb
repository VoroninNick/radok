class ImportWizardProjectLanguagesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_project_languages;

      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(1,'English','2015-11-13 09:52:50.422307','2015-11-13 09:52:50.422307');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(2,'German','2015-11-13 09:53:02.553803','2015-12-24 13:57:03.130891');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(3,'Polish','2015-11-13 09:53:14.157072','2015-12-24 13:56:53.049388');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(4,'Russian','2015-11-13 09:53:46.066220','2015-12-24 13:56:41.162551');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_project_languages;
    SQL
  end
end
