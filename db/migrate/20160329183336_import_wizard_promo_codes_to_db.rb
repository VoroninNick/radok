class ImportWizardPromoCodesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM wizard_promo_codes;

      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(1,'466295',15.0,'2015-11-26 18:40:23.452473','2015-11-26 18:40:23.452473');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(2,'650601',11.0,'2015-11-26 18:40:23.607559','2015-11-26 18:40:23.607559');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(3,'192537',18.0,'2015-11-26 18:40:23.734004','2015-11-26 18:40:23.734004');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(4,'919286',3.0,'2015-11-26 18:40:23.860080','2015-11-26 18:40:23.860080');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(5,'651782',18.0,'2015-11-26 18:40:23.985203','2015-11-26 18:40:23.985203');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(6,'366603',4.0,'2015-11-26 18:40:24.118922','2015-11-26 18:40:24.118922');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(7,'431185',1.0,'2015-11-26 18:40:24.244580','2015-11-26 18:40:24.244580');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(8,'512539',13.0,'2015-11-26 18:40:24.377638','2015-11-26 18:40:24.377638');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(9,'366929',2.0,'2015-11-26 18:40:24.586415','2015-11-26 18:40:24.586415');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(10,'300271',9.0,'2015-11-26 18:40:24.754423','2015-11-26 18:40:24.754423');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(11,'362108',2.0,'2015-11-26 18:40:24.880055','2015-11-26 18:40:24.880055');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(12,'909917',1.0,'2015-11-26 18:40:24.988755','2015-11-26 18:40:24.988755');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(13,'216520',7.0,'2015-11-26 18:40:25.138021','2015-11-26 18:40:25.138021');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(14,'179299',4.0,'2015-11-26 18:40:25.260040','2015-11-26 18:40:25.260040');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(15,'234602',16.0,'2015-11-26 18:40:25.397227','2015-11-26 18:40:25.397227');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(16,'564442',7.0,'2015-11-26 18:40:25.565104','2015-11-26 18:40:25.565104');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(17,'925345',19.0,'2015-11-26 18:40:25.690414','2015-11-26 18:40:25.690414');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(18,'489681',2.0,'2015-11-26 18:40:25.816001','2015-11-26 18:40:25.816001');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(19,'223134',10.0,'2015-11-26 18:40:25.942198','2015-11-26 18:40:25.942198');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(20,'912686',2.0,'2015-11-26 18:40:26.109220','2015-11-26 18:40:26.109220');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(21,'555302',7.0,'2015-11-26 18:40:26.243407','2015-11-26 18:40:26.243407');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(22,'950513',8.0,'2015-11-26 18:40:26.377574','2015-11-26 18:40:26.377574');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(23,'438625',4.0,'2015-11-26 18:40:26.510965','2015-11-26 18:40:26.510965');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(24,'530730',13.0,'2015-11-26 18:40:26.644274','2015-11-26 18:40:26.644274');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(25,'683118',3.0,'2015-11-26 18:40:27.105410','2015-11-26 18:40:27.105410');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(26,'690049',7.0,'2015-11-26 18:40:27.383588','2015-11-26 18:40:27.383588');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(27,'655029',4.0,'2015-11-26 18:40:27.612591','2015-11-26 18:40:27.612591');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(28,'320768',6.0,'2015-11-26 18:40:27.772878','2015-11-26 18:40:27.772878');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(29,'596958',7.0,'2015-11-26 18:40:27.988699','2015-11-26 18:40:27.988699');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(30,'437022',15.0,'2015-11-26 18:40:28.180554','2015-11-26 18:40:28.180554');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(31,'772786',18.0,'2015-11-26 18:40:28.366149','2015-11-26 18:40:28.366149');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(32,'267435',4.0,'2015-11-26 18:40:28.498689','2015-11-26 18:40:28.498689');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(33,'232459',6.0,'2015-11-26 18:40:28.624451','2015-11-26 18:40:28.624451');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(34,'592371',16.0,'2015-11-26 18:40:28.750952','2015-11-26 18:40:28.750952');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(35,'278500',19.0,'2015-11-26 18:40:28.884217','2015-11-26 18:40:28.884217');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(36,'843859',4.0,'2015-11-26 18:40:29.018072','2015-11-26 18:40:29.018072');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(37,'711804',10.0,'2015-11-26 18:40:29.160707','2015-11-26 18:40:29.160707');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(38,'435669',7.0,'2015-11-26 18:40:29.311224','2015-11-26 18:40:29.311224');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(39,'843906',16.0,'2015-11-26 18:40:29.504246','2015-11-26 18:40:29.504246');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(40,'503021',19.0,'2015-11-26 18:40:29.665733','2015-11-26 18:40:29.665733');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(41,'465612',5.0,'2015-11-26 18:40:29.806396','2015-11-26 18:40:29.806396');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(42,'975713',15.0,'2015-11-26 18:40:29.931417','2015-11-26 18:40:29.931417');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(43,'439108',14.0,'2015-11-26 18:40:30.156345','2015-11-26 18:40:30.156345');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(44,'652202',20.0,'2015-11-26 18:40:30.350094','2015-11-26 18:40:30.350094');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(45,'215829',5.0,'2015-11-26 18:40:30.566487','2015-11-26 18:40:30.566487');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(46,'980587',12.0,'2015-11-26 18:40:30.720969','2015-11-26 18:40:30.720969');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(47,'687101',16.0,'2015-11-26 18:40:31.008234','2015-11-26 18:40:31.008234');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(48,'139737',5.0,'2015-11-26 18:40:31.249794','2015-11-26 18:40:31.249794');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(49,'246269',18.0,'2015-11-26 18:40:31.392067','2015-11-26 18:40:31.392067');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(50,'291223',16.0,'2015-11-26 18:40:31.534282','2015-11-26 18:40:31.534282');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(51,'725074',11.0,'2015-11-26 18:40:31.685113','2015-11-26 18:40:31.685113');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(52,'217397',16.0,'2015-11-26 18:40:31.828615','2015-11-26 18:40:31.828615');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(53,'394185',17.0,'2015-11-26 18:40:31.963399','2015-11-26 18:40:31.963399');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(54,'982678',10.0,'2015-11-26 18:40:32.206487','2015-11-26 18:40:32.206487');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(55,'139145',20.0,'2015-11-26 18:40:32.389219','2015-11-26 18:40:32.389219');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(56,'532478',15.0,'2015-11-26 18:40:32.497285','2015-11-26 18:40:32.497285');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(57,'192860',17.0,'2015-11-26 18:40:32.664712','2015-11-26 18:40:32.664712');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(58,'491327',7.0,'2015-11-26 18:40:32.791975','2015-11-26 18:40:32.791975');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(59,'237698',20.0,'2015-11-26 18:40:33.078731','2015-11-26 18:40:33.078731');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(60,'462591',13.0,'2015-11-26 18:40:33.315897','2015-11-26 18:40:33.315897');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(61,'915147',1.0,'2015-11-26 18:40:33.550006','2015-11-26 18:40:33.550006');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(62,'691987',9.0,'2015-11-26 18:40:33.667834','2015-11-26 18:40:33.667834');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(63,'733042',2.0,'2015-11-26 18:40:33.875522','2015-11-26 18:40:33.875522');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(64,'986206',12.0,'2015-11-26 18:40:34.093269','2015-11-26 18:40:34.093269');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(65,'485624',1.0,'2015-11-26 18:40:34.275966','2015-11-26 18:40:34.275966');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(66,'923303',13.0,'2015-11-26 18:40:34.528150','2015-11-26 18:40:34.528150');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(67,'221784',7.0,'2015-11-26 18:40:34.686784','2015-11-26 18:40:34.686784');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(68,'174772',13.0,'2015-11-26 18:40:34.836536','2015-11-26 18:40:34.836536');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(69,'985977',13.0,'2015-11-26 18:40:35.153204','2015-11-26 18:40:35.153204');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(70,'661283',14.0,'2015-11-26 18:40:35.306920','2015-11-26 18:40:35.306920');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(71,'175755',5.0,'2015-11-26 18:40:35.559725','2015-11-26 18:40:35.559725');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(72,'883883',10.0,'2015-11-26 18:40:35.742106','2015-11-26 18:40:35.742106');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(73,'528359',2.0,'2015-11-26 18:40:35.875561','2015-11-26 18:40:35.875561');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(74,'447899',5.0,'2015-11-26 18:40:36.057460','2015-11-26 18:40:36.057460');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(75,'715717',7.0,'2015-11-26 18:40:36.183961','2015-11-26 18:40:36.183961');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(76,'858297',9.0,'2015-11-26 18:40:36.300479','2015-11-26 18:40:36.300479');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(77,'482418',16.0,'2015-11-26 18:40:36.508982','2015-11-26 18:40:36.508982');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(78,'935357',9.0,'2015-11-26 18:40:36.752448','2015-11-26 18:40:36.752448');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(79,'331010',8.0,'2015-11-26 18:40:36.970398','2015-11-26 18:40:36.970398');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(80,'965133',15.0,'2015-11-26 18:40:37.129384','2015-11-26 18:40:37.129384');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(81,'960600',14.0,'2015-11-26 18:40:37.337195','2015-11-26 18:40:37.337195');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(82,'960889',16.0,'2015-11-26 18:40:37.471329','2015-11-26 18:40:37.471329');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(83,'978257',19.0,'2015-11-26 18:40:37.696561','2015-11-26 18:40:37.696561');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(84,'162762',19.0,'2015-11-26 18:40:37.822001','2015-11-26 18:40:37.822001');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(85,'847809',17.0,'2015-11-26 18:40:38.006380','2015-11-26 18:40:38.006380');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(86,'465902',12.0,'2015-11-26 18:40:38.156328','2015-11-26 18:40:38.156328');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(87,'287223',11.0,'2015-11-26 18:40:38.316109','2015-11-26 18:40:38.316109');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(88,'506176',12.0,'2015-11-26 18:40:38.494378','2015-11-26 18:40:38.494378');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(89,'119696',3.0,'2015-11-26 18:40:38.616941','2015-11-26 18:40:38.616941');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(90,'266120',10.0,'2015-11-26 18:40:38.750024','2015-11-26 18:40:38.750024');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(91,'781634',19.0,'2015-11-26 18:40:38.950402','2015-11-26 18:40:38.950402');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(92,'865816',12.0,'2015-11-26 18:40:39.084571','2015-11-26 18:40:39.084571');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(93,'490715',13.0,'2015-11-26 18:40:39.226652','2015-11-26 18:40:39.226652');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(94,'825111',2.0,'2015-11-26 18:40:39.361518','2015-11-26 18:40:39.361518');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(95,'511614',5.0,'2015-11-26 18:40:39.586039','2015-11-26 18:40:39.586039');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(96,'251658',19.0,'2015-11-26 18:40:39.785725','2015-11-26 18:40:39.785725');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(97,'864519',17.0,'2015-11-26 18:40:39.987917','2015-11-26 18:40:39.987917');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(98,'155905',8.0,'2015-11-26 18:40:40.113875','2015-11-26 18:40:40.113875');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(99,'137274',12.0,'2015-11-26 18:40:40.245057','2015-11-26 18:40:40.245057');
      INSERT INTO wizard_promo_codes (id, password, percentage_discount, created_at, updated_at) VALUES(100,'566878',9.0,'2015-11-26 18:40:40.379764','2015-11-26 18:40:40.379764');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM wizard_promo_codes;
    SQL
  end
end
