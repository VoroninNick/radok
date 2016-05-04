class ImportPagesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM pages;

      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(1,'Pages::HowItWorks',NULL,'','/crowdsourced-testing-process','2015-09-23 18:51:14.000694','2016-02-11 17:26:38.191345');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(3,'Pages::About',NULL,'','/crowdsourced-company-about','2015-09-23 19:19:13.558410','2016-02-11 16:25:47.315818');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(4,'Pages::Contact',NULL,'','/crowdsourced-testing-contact','2015-09-23 19:19:54.261268','2015-10-14 15:49:22.574697');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(5,'Pages::Pricing',NULL,'','/crowdsouced-testing-cost','2015-09-23 19:21:13.444009','2016-02-08 12:42:32.492959');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(6,'Pages::TestingServices',NULL,'','/crowdsourced-testing-services','2015-09-23 19:23:23.221982','2016-02-03 17:11:10.749969');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(7,'Pages::Home',NULL,NULL,NULL,'2015-09-25 13:37:02.319653','2015-09-25 13:37:02.319653');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(8,'Pages::Dashboard',NULL,NULL,NULL,'2015-10-06 10:12:21.794605','2015-10-06 10:12:21.794605');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(9,'Pages::Devices',NULL,'','/devices','2015-10-06 10:40:51.081872','2016-02-05 14:17:27.957053');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(10,'Pages::Wizard',NULL,NULL,'/ordering-crowdsourced-testing ','2015-10-06 10:42:44.123463','2015-10-14 15:59:07.483227');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(11,'Pages::FaqIndex',NULL,NULL,'','2015-10-06 10:58:53.714994','2015-10-16 16:41:51.140440');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(12,'Pages::SignUp',NULL,NULL,NULL,'2016-01-20 16:01:17.987316','2016-01-20 16:01:17.987316');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(13,'Pages::SignIn',NULL,NULL,NULL,'2016-01-20 16:01:18.013759','2016-01-20 16:01:18.013759');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(14,'Pages::TestInfo',NULL,NULL,NULL,'2016-01-20 16:01:18.032401','2016-01-20 16:01:18.032401');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(15,'Pages::RobotsTxt',NULL,NULL,NULL,'2016-01-20 16:01:18.059284','2016-01-20 16:01:18.059284');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(16,'Pages::NotFound',NULL,NULL,NULL,'2016-01-20 16:01:18.077398','2016-01-20 16:01:18.077398');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(17,'Pages::Profile',NULL,NULL,NULL,'2016-01-20 16:01:18.102597','2016-01-20 16:01:18.102597');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(18,'Pages::SitemapXml',NULL,NULL,NULL,'2016-01-20 17:26:04.699512','2016-01-20 17:26:04.699512');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(21,'Templates::PayLaterRequestAdminNotification',NULL,NULL,NULL,'2016-02-11 15:23:35.794168','2016-02-11 15:23:35.794168');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(22,'Templates::PaymentRequestAdminNotification',NULL,NULL,NULL,'2016-02-11 15:24:31.711084','2016-02-11 15:24:31.711084');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(23,'Templates::ScheduleCallAdminNotification',NULL,NULL,NULL,'2016-02-11 15:25:03.259243','2016-02-11 15:25:03.259243');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(24,'Templates::ConfirmationInstructions',NULL,NULL,NULL,'2016-02-11 15:36:11.308725','2016-02-11 15:36:11.308725');
      INSERT INTO pages (id, type, name, content, url, created_at, updated_at) VALUES(26,'Templates::WelcomeEmail',NULL,NULL,NULL,'2016-02-11 15:37:09.571284','2016-02-11 15:37:09.571284');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM pages;
    SQL
  end
end
