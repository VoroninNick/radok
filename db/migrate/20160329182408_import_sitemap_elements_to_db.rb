class ImportSitemapElementsToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM sitemap_elements;

      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(1,'Page',3,'t','default',0.5,'2015-10-16 16:40:29.897034','2015-10-16 16:40:29.897034');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(2,'Page',4,'t','default',0.5,'2015-10-16 16:41:17.083788','2015-10-16 16:41:17.083788');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(3,'Page',9,'t','default',0.5,'2015-10-16 16:41:40.647860','2015-10-16 16:41:40.647860');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(4,'Page',11,'t','default',0.5,'2015-10-16 16:41:51.146974','2015-10-16 16:41:51.146974');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(5,'Page',7,'t','default',0.5,'2015-10-16 16:43:18.968583','2015-10-16 16:43:24.521238');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(6,'Page',1,'t','default',0.5,'2015-10-16 16:43:48.728388','2015-10-16 16:43:48.728388');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(7,'Page',5,'t','default',0.5,'2015-10-16 16:44:00.406137','2015-10-16 16:44:00.406137');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(8,'Page',6,'t','default',0.5,'2015-10-16 16:44:12.052736','2015-10-16 16:44:12.052736');
      INSERT INTO sitemap_elements (id, page_type, page_id, display_on_sitemap, changefreq, priority, created_at, updated_at) VALUES(9,'FaqArticle',1,'t','default',0.5,'2015-10-16 16:44:28.852689','2015-10-16 16:44:28.852689');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM sitemap_elements;
    SQL
  end
end
