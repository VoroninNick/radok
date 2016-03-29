class ImportWizardTestPlatformsToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_test_platforms;

      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,8,8,'2015-09-30 09:23:38.380021','2015-09-30 09:23:38.380021',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(4,3,1,'2015-10-06 08:02:46.279233','2015-10-06 08:02:46.279233',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(4,10,2,'2015-10-08 11:57:26.234515','2015-10-08 11:57:26.234515',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(6,10,1,'2015-10-08 11:57:26.247744','2015-10-08 11:57:26.247744',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(7,10,1,'2015-10-08 11:57:26.260297','2015-10-08 11:57:26.260297',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(4,12,2,'2015-10-08 12:32:06.566807','2015-10-08 12:32:06.566807',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,14,1,'2015-10-08 12:36:01.075961','2015-10-08 12:36:01.075961',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,18,1,'2015-10-19 09:23:01.139556','2015-10-19 09:23:01.139556',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,18,1,'2015-10-19 09:23:01.155277','2015-10-19 09:23:01.155277',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(12,18,3,'2015-10-19 09:23:01.165585','2015-10-19 09:23:01.165585',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(13,18,1,'2015-10-19 09:23:01.175738','2015-10-19 09:23:01.175738',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(14,18,1,'2015-10-19 09:23:01.185052','2015-10-19 09:23:01.185052',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(15,18,80,'2015-10-19 09:23:01.194117','2015-10-19 09:23:01.194117',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(17,18,4,'2015-10-19 09:23:01.203270','2015-10-19 09:23:01.203270',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(18,18,12,'2015-10-19 09:23:01.212338','2015-10-19 09:23:01.212338',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(7,32,1,'2015-10-23 11:09:15.259565','2015-10-23 11:09:15.259565',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(7,33,4,'2015-10-23 11:40:46.931252','2015-10-23 11:40:46.931252',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,38,0,'2015-11-11 16:38:26.376138','2015-11-11 16:38:26.376138',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,40,0,'2015-11-11 16:40:26.651321','2015-11-11 16:40:26.651321',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,40,0,'2015-11-11 16:40:31.118853','2015-11-11 16:40:31.118853',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,41,0,'2015-11-11 16:41:46.354895','2015-11-11 16:41:46.354895',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(20,41,0,'2015-11-11 16:41:48.508794','2015-11-11 16:41:48.508794',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,43,0,'2015-11-11 20:00:26.120025','2015-11-11 20:00:26.120025',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,44,0,'2015-11-11 20:26:54.280612','2015-11-11 20:26:54.280612',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,45,0,'2015-11-12 08:55:30.874226','2015-11-12 08:55:30.874226',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,47,0,'2015-11-13 09:55:34.906543','2015-11-13 09:55:34.906543',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,48,0,'2015-11-13 12:08:20.229695','2015-11-13 12:08:20.229695',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,49,0,'2015-11-13 15:51:53.711841','2015-11-13 15:51:53.711841',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,50,0,'2015-11-13 16:49:20.868350','2015-11-13 16:49:20.868350',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,54,0,'2015-11-14 11:03:28.062558','2015-11-14 11:03:28.062558',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,55,0,'2015-11-14 12:42:46.578059','2015-11-14 12:42:46.578059',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,56,0,'2015-11-14 16:50:55.596345','2015-11-14 16:50:55.596345',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,57,0,'2015-11-14 17:01:13.502056','2015-11-14 17:01:13.502056',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,58,0,'2015-11-14 17:04:58.877457','2015-11-14 17:04:58.877457',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(3,58,0,'2015-11-14 17:04:58.890246','2015-11-14 17:04:58.890246',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(1,63,0,'2015-11-14 17:29:20.946632','2015-11-14 17:29:20.946632',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(2,65,0,'2015-11-14 18:16:23.451083','2015-11-14 18:16:23.451083',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(41,65,0,'2015-11-14 18:16:23.461952','2015-11-14 18:16:23.461952',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,67,2,'2015-11-16 13:57:50.293181','2015-11-16 14:03:25.565392',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,67,1,'2015-11-16 13:57:50.299758','2015-11-16 13:57:50.299758',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(12,67,1,'2015-11-16 13:57:50.305687','2015-11-16 13:57:50.305687',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(13,67,1,'2015-11-16 13:57:50.311584','2015-11-16 13:57:50.311584',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(14,67,1,'2015-11-16 13:57:50.317365','2015-11-16 13:57:50.317365',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(15,67,1,'2015-11-16 13:57:50.322982','2015-11-16 13:57:50.322982',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(42,67,1,'2015-11-16 13:57:50.328423','2015-11-16 13:57:50.328423',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(43,67,1,'2015-11-16 13:57:50.333859','2015-11-16 13:57:50.333859',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(44,67,1,'2015-11-16 13:57:50.339665','2015-11-16 13:57:50.339665',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(45,67,1,'2015-11-16 13:57:50.345687','2015-11-16 13:57:50.345687',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(46,67,1,'2015-11-16 13:57:50.351695','2015-11-16 13:57:50.351695',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(47,67,1,'2015-11-16 13:57:50.397736','2015-11-16 13:57:50.397736',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(48,67,1,'2015-11-16 13:57:50.403340','2015-11-16 13:57:50.403340',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(7,70,1,'2015-11-16 14:12:32.832866','2015-11-16 14:12:32.832866',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(8,70,1,'2015-11-16 14:12:35.076498','2015-11-16 14:12:35.076498',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,71,1,'2015-11-16 14:31:52.958094','2015-11-16 14:31:52.958094',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(12,72,1,'2015-11-16 14:33:26.924218','2015-11-16 14:33:26.924218',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,78,1,'2015-11-17 15:05:38.148058','2015-11-17 15:05:38.148058',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,78,1,'2015-11-17 15:05:38.153712','2015-11-17 15:05:38.153712',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,79,2,'2015-11-17 15:11:18.551923','2015-11-17 15:11:18.551923',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(43,79,2,'2015-11-17 15:11:21.512441','2015-11-17 15:11:21.512441',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,83,3,'2015-11-18 10:57:39.994512','2015-11-18 10:57:48.472770',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(16,83,1,'2015-11-18 10:57:53.629329','2015-11-18 10:57:53.629329',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(42,83,1,'2015-11-18 10:58:00.299722','2015-11-18 10:58:00.299722',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(37,85,1,'2015-11-18 11:05:34.741157','2015-11-18 11:05:34.741157',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(42,86,3,'2015-11-18 11:15:41.871084','2015-11-18 11:15:41.871084',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,86,8,'2015-11-18 11:15:52.780022','2015-11-18 11:15:52.780022',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(37,88,6,'2015-11-18 17:26:07.894566','2015-11-18 17:26:07.894566',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(38,88,5,'2015-11-18 17:26:07.905705','2015-11-18 17:26:07.905705',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,89,1,'2015-11-18 21:33:52.348865','2015-11-18 21:33:52.348865',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,89,1,'2015-11-18 21:33:52.355394','2015-11-18 21:33:52.355394',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(12,89,1,'2015-11-18 21:33:52.361742','2015-11-18 21:33:52.361742',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(13,89,1,'2015-11-18 21:33:52.368103','2015-11-18 21:33:52.368103',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(14,89,1,'2015-11-18 21:33:52.374270','2015-11-18 21:33:52.374270',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,90,1,'2015-11-19 19:54:20.075825','2015-11-19 19:54:20.075825',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(15,91,1,'2015-11-19 21:21:48.163014','2015-11-19 21:21:48.163014',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,92,1,'2015-11-20 10:45:35.299467','2015-11-20 10:45:35.299467',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,94,5,'2015-11-20 14:37:40.240598','2015-11-20 14:37:40.240598',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,95,5,'2015-11-20 14:38:28.970122','2015-11-20 14:38:28.970122',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,96,9,'2015-11-20 17:43:27.635208','2015-11-20 17:43:27.635208',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(11,96,7,'2015-11-20 17:43:47.754054','2015-11-20 17:43:47.754054',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(16,96,10,'2015-11-20 17:43:47.766640','2015-11-20 17:43:47.766640',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(17,96,4,'2015-11-20 17:43:47.786857','2015-11-20 17:43:47.786857',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(18,96,9,'2015-11-20 17:43:47.805681','2015-11-20 17:43:47.805681',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(43,96,11,'2015-11-20 17:43:47.831471','2015-11-20 17:43:47.831471',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(54,96,9,'2015-11-20 17:43:47.844546','2015-11-20 17:43:47.844546',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,97,1,'2015-11-21 11:56:48.195077','2015-11-21 11:56:48.195077',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(43,98,1,'2015-11-21 12:02:10.127298','2015-11-21 12:02:10.127298',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,99,1,'2015-11-23 09:13:55.582810','2015-11-23 09:13:55.582810',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(17,99,1,'2015-11-23 09:13:55.589721','2015-11-23 09:13:55.589721',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(7,102,1,'2015-11-23 15:36:56.674712','2015-11-23 15:36:56.674712',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(8,102,1,'2015-11-23 15:36:56.681058','2015-11-23 15:36:56.681058',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(9,102,1,'2015-11-23 15:37:01.844086','2015-11-23 15:37:01.844086',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(35,102,1,'2015-11-23 15:37:01.850015','2015-11-23 15:37:01.850015',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,106,12,'2015-11-25 20:58:59.560324','2015-11-25 20:59:07.934467',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(35,108,4,'2015-11-26 10:39:32.452697','2015-11-26 10:39:32.452697',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,109,4,'2015-11-26 18:46:04.760367','2015-11-26 18:46:04.760367',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,110,1,'2015-11-27 09:45:26.761882','2015-11-27 09:45:26.761882',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(8,111,1,'2015-11-27 10:07:28.032952','2015-11-27 10:07:28.032952',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(9,111,1,'2015-11-27 10:07:28.038441','2015-11-27 10:07:28.038441',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,113,4,'2015-11-28 15:16:59.360260','2015-11-28 15:16:59.360260',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,116,6,'2015-12-02 13:23:34.863771','2015-12-02 13:23:41.863571',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,117,3,'2015-12-02 13:37:16.952800','2015-12-02 13:37:16.952800',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(10,121,1,'2015-12-26 19:34:11.653243','2015-12-26 19:34:36.346107',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(37,122,1,'2015-12-26 20:25:24.615249','2015-12-26 20:25:24.615249',NULL);
      INSERT INTO wizard_test_platforms (platform_id, test_id, testers_count, created_at, updated_at, comment) VALUES(37,124,1,'2016-02-11 20:42:07.807309','2016-02-11 20:42:07.807309',NULL);
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_test_platforms;
    SQL
  end
end
