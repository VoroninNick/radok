class ImportWizardPlatformsProductTypesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_platforms_product_types;

      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(1,2);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(3,4);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(2,4);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(3,1);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(2,1);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(41,1);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(36,3);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(41,4);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(52,4);
      INSERT INTO wizard_platforms_product_types (platform_id, product_type_id) VALUES(36,4);
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_platforms_product_types;
    SQL
  end
end
