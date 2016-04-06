class ImportWizardProductTypesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_product_types;

      INSERT INTO wizard_product_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(1,'Mobile apps','rf-mobile-apps.svg','image/svg+xml',17106,'2015-09-23 10:38:18.370294','2015-09-23 10:38:18.563165','2015-09-23 10:38:18.563165');
      INSERT INTO wizard_product_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(2,'Web Application','rf-responsive.svg','image/svg+xml',7631,'2015-09-23 10:39:00.490595','2015-09-23 10:39:00.506045','2016-02-05 13:03:18.983423');
      INSERT INTO wizard_product_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(3,'Software','rf-software.svg','image/svg+xml',4635,'2015-09-23 10:39:25.754138','2015-09-23 10:39:25.769720','2015-09-23 10:39:25.769720');
      INSERT INTO wizard_product_types (id, name, image_file_name, image_content_type, image_file_size, image_updated_at, created_at, updated_at) VALUES(4,'Games','rf-games.svg','image/svg+xml',10785,'2015-09-23 10:40:10.037811','2015-09-23 10:40:10.054906','2015-09-23 10:40:10.054906');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_product_types;
    SQL
  end
end
