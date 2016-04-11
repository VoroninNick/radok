class ImportClients < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM banners;

      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(1,'Apple','apple.svg','image/svg+xml',1015,'2016-02-11 16:19:27.747270',1,'http://apple.com','2016-02-11 16:19:28.135299','2016-02-11 16:43:02.755970');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(2,'Microsoft','microsoft.svg','image/svg+xml',7097,'2016-02-11 16:20:10.370279',2,'http://microsoft.com','2016-02-11 16:20:10.679088','2016-02-11 16:43:02.765669');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(3,'Electronic Arts: EA Games','ea.svg','image/svg+xml',754,'2016-02-11 16:21:18.998011',3,'http://ea.com','2016-02-11 16:21:19.297287','2016-02-11 16:42:51.413585');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(4,'Adobe','adobe.svg','image/svg+xml',2729,'2016-02-11 16:21:54.956682',4,'http://adobe.com','2016-02-11 16:21:55.286948','2016-02-11 16:42:51.421107');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(5,'Intel','intel.svg','image/svg+xml',5288,'2016-02-11 16:22:24.467474',5,'http://intel.com','2016-02-11 16:22:24.857595','2016-02-11 16:42:51.428640');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(6,'Lenovo','lenovo.svg','image/svg+xml',2494,'2016-02-11 16:23:02.284405',6,'http://lenovo.com','2016-02-11 16:23:02.511827','2016-02-11 16:42:51.435777');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(7,'Logitech','logitech.svg','image/svg+xml',5413,'2016-02-11 16:23:43.081423',7,'http://logitech.com','2016-02-11 16:23:43.351044','2016-02-11 16:42:51.443187');
      INSERT INTO clients (id, name, logo_file_name, logo_content_type, logo_file_size, logo_updated_at, sorting_position, client_url, created_at, updated_at) VALUES(8,'Nokia','nokia.svg','image/svg+xml',1811,'2016-02-11 16:24:18.118487',8,'http://nokia.com','2016-02-11 16:24:18.346291','2016-02-11 16:42:51.450960');
    SQL

    {
      '1' => 'apple.svg',
      '2' => 'microsoft.svg',
      '3' => 'ea.svg',
      '4' => 'adobe.svg',
      '5' => 'intel.svg',
      '6' => 'lenovo.svg',
      '7' => 'logitech.svg',
      '8' => 'nokia.svg'
    }.each do |id, image|
      client = Client.find(id)
      file = File.open(Rails.root.join('fixtures', 'images', image))
      client.logo = file
      file.close
      client.save!
    end
  end

  def down
    execute(<<-SQL)
      DELETE FROM clients;
    SQL
  end
end
