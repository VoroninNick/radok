class ImportWizardProjectLanguagesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_project_languages;

      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(1,'English','2015-11-13 09:52:50.422307','2015-11-13 09:52:50.422307');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(2,'French','2015-11-13 09:53:02.553803','2015-11-13 09:53:02.553803');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(3,'Spanish','2015-11-13 09:53:14.157072','2015-11-13 09:53:14.157072');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(4,'Dutch','2015-11-13 09:53:46.066220','2015-11-13 09:53:46.066220');
      INSERT INTO wizard_project_languages (id, name, created_at, updated_at) VALUES(5,'Portuguese','2015-11-13 09:53:57.966419','2015-11-13 09:53:57.966419');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_project_languages;
    SQL
  end
end
