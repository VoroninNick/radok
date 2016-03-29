class ImportBannersToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM banners;
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(1,3,'Speed, quality and good reputation','It''s about us','radok-web-banner-about-us.png','image/png',61607,'2015-10-06 10:38:03.419076','','','2015-10-06 10:09:13.051635','2015-10-14 17:14:36.495976','h1');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(2,8,'My dashboard','See your projects here','radok-web-banner-dashboard.png','image/png',51602,'2015-10-06 10:40:18.134764','New test','/ordering-crowdsourced-testing','2015-10-06 10:12:21.800451','2015-10-16 16:53:03.270347','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(3,4,'Contact us','','contacts.jpg','image/jpeg',91847,'2015-10-06 10:39:39.462184','','','2015-10-06 10:39:39.498825','2015-10-14 17:08:02.319851','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(4,9,'','','radok-web-banner-device-lab-2.png','image/png',166077,'2015-10-06 10:40:51.060108','','','2015-10-06 10:40:51.092248','2015-10-14 17:08:02.437748','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(5,1,'How to get results without pressure?','','radok-web-banner-about-us.png','image/png',61607,'2015-10-06 10:41:47.981243','','','2015-10-06 10:41:48.008954','2015-10-14 17:08:02.563200','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(6,5,'Economic software testing solution','','radok-web-banner-pricing.png','image/png',61452,'2015-10-06 10:42:14.225537','','','2015-10-06 10:42:14.260962','2015-10-14 17:09:14.556352','h1');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(7,6,'The level of testing you need','','radok-web-banner-testing-services.png','image/png',43167,'2015-10-06 10:42:31.429459','','','2015-10-06 10:42:31.494665','2015-10-14 17:08:02.800463','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(8,10,'','','radok-web-banner-wizard.png','image/png',52378,'2015-10-06 10:42:44.090407','','','2015-10-06 10:42:44.133588','2015-10-14 17:08:02.934476','div');
      INSERT INTO banners (id, page_id, title, description, background_image_file_name, background_image_content_type, background_image_file_size, background_image_updated_at, button_label, button_url, created_at, updated_at, title_html_tag) VALUES(9,11,'','','radok-web-banner-FAQ.png','image/png',67093,'2015-10-06 10:58:53.681720','','','2015-10-06 10:58:53.722225','2015-10-14 17:08:03.068149','div');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM banners;
    SQL
  end
end
