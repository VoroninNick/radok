class ImportSeoTagsToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM seo_tags;

      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(1,NULL,1,'How it works','How it works keywords','How it works description','2015-09-23 18:51:38.091711','2015-09-23 19:15:37.456614');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(2,NULL,3,'About','About keywords','About description','2015-09-23 19:19:13.689545','2015-09-23 19:19:13.689545');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(3,NULL,4,'Contact','contact keywords','contact-description','2015-09-23 19:19:54.266235','2015-09-23 19:19:54.266235');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(4,NULL,5,'Pricing','pricing keywords','pricing description','2015-09-23 19:21:13.623380','2015-09-23 19:21:13.623380');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(5,NULL,6,'Testing services','testing-services keywords','testing-services description','2015-09-23 19:23:23.354238','2015-09-23 19:23:23.354238');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(6,NULL,7,'Home page','home page keywords','home page description','2015-09-25 13:37:02.325655','2015-09-25 13:37:02.325655');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(7,'FaqArticle',1,'','','','2015-09-25 15:12:03.742277','2015-09-25 15:24:15.308025');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(8,'Page',7,'Crowdsourced testing by 10G Force | Software testing','','sense the speed of 10G Force testing your software product at our crowd sourcing platform with a  competent team of qualified testers.','2015-10-14 16:12:49.946613','2015-10-14 16:12:49.946613');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(9,'Page',6,'Crowdsourced Testing Services | 10G Force','','Deadline is close? Do you need functional, localization or usability testing? We crowd test every platform with a force of 10G-Force.  ','2015-10-14 16:13:52.318311','2016-01-18 16:15:25.938623');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(10,'Page',5,'Crowdsourced testing cost | Pricing plan by 10G Force ','','Our simple self-driving plan costs $39 per hour/platform or define your expectations for a special software product with our devoted project manager.  ','2015-10-14 16:14:27.806785','2016-01-22 09:26:50.150378');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(12,'Page',3,'About crowdsourced company 10G Force','',' Our software testers are  unique and have been trained to the highest possible professional level. Enabling us to guarantee  fast result testing for your product.','2015-10-14 16:16:49.368200','2015-10-14 16:16:49.368200');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(13,'Page',1,'10G-Force: How it works','how it works, testing service, 10g','On this page you will find info about how it works!','2015-10-14 16:16:55.576008','2015-10-14 16:16:55.576008');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(14,'Page',4,'Our contacts | 10G Force','','Any question or comment please contact us.','2015-10-14 16:17:18.322464','2015-10-14 16:17:18.322464');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(15,'Page',19,'Terms of use','','','2016-01-20 17:58:43.804519','2016-01-20 17:58:43.804519');
      INSERT INTO seo_tags (id, page_type, page_id, title, keywords, description, created_at, updated_at) VALUES(16,'Page',9,'Devices','','','2016-02-05 13:01:23.063804','2016-02-05 13:01:23.063804');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM seo_tags;
    SQL
  end
end
