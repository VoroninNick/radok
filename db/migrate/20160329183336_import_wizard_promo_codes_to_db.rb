class ImportWizardPromoCodesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_promo_codes;

      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(1,'123541',10.0,'2015-11-26 18:51:24.304172','2015-11-26 18:51:24.304172');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(2,'vipcustomer',5.0,'2016-01-13 11:31:04.542893','2016-01-13 11:31:04.542893');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_promo_codes;
    SQL
  end
end
