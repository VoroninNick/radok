class ImportWizardTestTypesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_test_types;

      INSERT INTO wizard_test_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(2,'Functional','rf-functional-test.svg','image/svg+xml',22678,'2015-10-08 12:09:07.666935','2015-10-08 12:09:07.691230','2015-10-08 12:09:07.691230');
      INSERT INTO wizard_test_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(3,'Localization','rf-localization-test.svg','image/svg+xml',4922,'2015-10-08 12:09:25.942272','2015-10-08 12:09:25.975800','2015-10-08 12:09:25.975800');
      INSERT INTO wizard_test_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(4,'Usability','rf-usability-test.svg','image/svg+xml',7639,'2015-10-08 12:09:41.293955','2015-10-08 12:09:41.348904','2015-10-08 12:09:41.348904');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_test_types;
    SQL
  end
end
