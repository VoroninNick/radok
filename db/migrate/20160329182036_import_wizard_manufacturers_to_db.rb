class ImportWizardManufacturersToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_manufacturers;

      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(1,'Acer','2015-10-06 08:12:49.802444','2015-10-06 08:12:49.802444');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(2,'Apple','2015-10-06 08:12:55.566992','2015-10-06 08:12:55.566992');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(3,'Amazon','2015-10-06 08:13:02.169001','2015-10-06 08:13:02.169001');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(4,'Asus','2015-10-23 08:22:26.397937','2015-10-23 08:22:26.397937');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(5,'Barnes & Noble','2015-10-23 08:32:51.905097','2015-10-23 08:32:51.905097');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(6,'BlackBerry','2015-10-23 08:34:38.903256','2015-10-23 08:34:38.903256');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(7,'Gigabyte','2015-10-23 08:37:06.516162','2015-10-23 08:37:06.516162');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(8,'HTC','2015-10-23 08:38:32.400639','2015-10-23 08:38:32.400639');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(9,'Huawei','2015-10-23 09:03:41.287410','2015-10-23 09:03:41.287410');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(10,'Jiayu','2015-10-23 09:08:17.009519','2015-10-23 09:08:17.009519');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(11,'Leagoo','2015-10-23 09:19:23.298566','2015-10-23 09:19:23.298566');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(12,'Lenovo','2015-10-23 09:22:23.586936','2015-10-23 09:22:23.586936');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(13,'LG','2015-10-23 09:57:24.079779','2015-10-23 09:57:24.079779');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(14,'Meizu','2015-10-23 10:13:26.014454','2015-10-23 10:13:26.014454');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(15,'Microsoft','2015-10-23 10:16:11.151269','2015-10-23 10:16:11.151269');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(16,'Modecom ','2015-10-23 10:17:42.067983','2015-10-23 10:17:42.067983');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(17,'Motorola','2015-10-23 10:19:55.847550','2015-10-23 10:19:55.847550');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(18,'Nokia','2015-10-23 10:25:40.182532','2015-10-23 10:25:40.182532');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(19,'PocketBook','2015-10-23 10:32:03.215597','2015-10-23 10:32:03.215597');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(20,'Prestigio','2015-10-23 10:33:20.936398','2015-10-23 10:33:20.936398');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(21,'Samsung','2015-10-23 11:06:58.423409','2015-10-23 11:06:58.423409');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(22,'Sony','2015-10-23 12:03:25.145261','2015-10-23 12:03:25.145261');
      INSERT INTO wizard_manufacturers (id, name, created_at, updated_at) VALUES(23,'Sony Ericsson','2015-10-23 12:07:56.015707','2015-10-23 12:07:56.015707');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_manufacturers;
    SQL
  end
end
