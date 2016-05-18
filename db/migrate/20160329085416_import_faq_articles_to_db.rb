class ImportFaqArticlesToDb < ActiveRecord::Migration
  def up
    execute(<<-SQL)
      DELETE FROM faq_articles;

      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(1,'t','What is 10G-Force?','<p>10G-Force is an online platform that gives you the opportunity to hire a first-class team of quality assurance professionals in the blink of an eye. Outsource your testing tasks and improve the quality of your apps. 10G-Force helps you to comprehensively test your app on on various (diverse) devices in real-world in real-world conditions with a minimum effort on your part!</p>
      ','2015-06-04 11:04:42.945149','2016-02-03 11:44:09.698982','what-is-10g-force');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(2,'t','Who are 10G-Force testers?','<p>Our testers are a team of 1500+ professional and certified Quality Assurance engineers with hands-on testing experience. We don&rsquo;t employ freelancers or juniors. All of our employees have proven their qualifications and have 3+ years of working experience. Our team<del cite="mailto:Соломія%20Писарева" datetime="2016-02-01T22:40">s</del> guarantee<ins cite="mailto:Соломія%20Писарева" datetime="2016-02-01T22:40">s</ins> an accurate, fast and cost-effective testing that ensures flawless products..</p>
      ','2015-06-04 11:05:28.759587','2016-02-03 11:45:14.597855','who-are-10g-force-testers');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(3,'t','How does the testing process look like?','<p>In order to hire our professional team, all you need to do is to fill out a simple short form to tell us about your project. Once you submit your requirements, a testing team will be assigned to you and you will be able to review the work progress as well as communicate with the team throughout the testing period. After thorough testing, you will receive comprehensive test reports and a defect list from our team, so that your developers will be able to efficiently find and fix existing bugs. Later, you can add more testing cycles to ensure that all defects were fixed and your product is of the highest quality for launch.</p>
      ','2015-06-04 11:06:01.142383','2015-10-16 09:19:44.746491','how-does-the-testing-process-look-like');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(4,'t','What is your privacy policy?','<p>Your project confidentiality is of a great importance for us. Due to this, we have very strict privacy policy with the following rules:</p>

      <ul>
      	<li>All our team members are required to sign a non-disclosure agreement that covers all of your projects.</li>
      	<li>Only the testers who are a part of your project testing team have access to any information provided.</li>
      	<li>We value our reputation, therefore we hire only high-quality specialists that can be trusted to be professional at all times.</li>
      </ul>
      ','2015-06-04 11:06:44.776456','2015-10-16 08:20:05.895388','what-is-your-privacy-policy');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(5,'t','What platforms do you test on?','<p>Based on your requirements, we have a diverse variety of real devices to perform testing on. We mainly focus on computers and mobile devices.</p>
      ','2015-06-04 11:26:40.017384','2015-10-16 08:41:25.464975','what-platforms-do-you-test-on');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(6,'t','How much does it cost?','<p>We offer a standart pricing package, which includes the most common testing deviсes and environments. No hidden payments - you can see the total cost before you even sign up. Also, you can customize your package and fit it for your needs. If you have any custom preferences, please contact us and we will work with you to meet your needs.</p>
      ','2015-06-04 11:27:10.042048','2016-02-03 11:45:57.022390','how-much-does-it-cost');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(7,'t','Can I get test reports sent directly to my bug-tracking system?','<p>Yes! You and your developers won&rsquo;t even feel the difference. Our testing team will work with your bug-tracking system and provide all bug reports and test results in a manner that is easy and convenient for you.</p>
      ','2015-06-04 11:27:35.016385','2016-02-03 11:47:17.986205','can-i-get-test-reports-directly-in-my-bug-tracking-system');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(8,'t','What kind of testing does 10G-Force perform?','<p>10G-Force mainly focuses on functional, localization, and UI/UX testing. You can choose the type of testing you would like to perform when filling out the request form.</p>
      ','2015-06-04 11:27:53.516286','2016-02-03 11:48:32.805680','what-kind-of-testing-does-radok-perform');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(9,'t','What results do I get?','<p>After thorough testing, you will receive a comprehensive test report and a defect list from our team. Each defect has standard attributes and you will be able to filter and sort all the bugs by type, severity, priority or app modules. Standard bug reports including comprehensive descriptions of the issue (with screenshots) will be presented to you and your developers. At the end of the testing process, you will also receive reliable statistics, according to the whole testing phase.</p>
      ','2015-06-04 11:28:13.837786','2016-02-03 11:50:24.706558','what-results-do-i-get');
      INSERT INTO faq_articles (id, published, name, content, created_at, updated_at, url_fragment) VALUES(10,'t','Can I contact my 10G-Force tester team?','<p>Of course! We believe that communication is the key to successful solutions. Once your project is assigned to the team, the team lead will contact you to clarify if you have any questions or specific requirements. During the entire testing period, you will be able to communicate with your team whenever you want in a way that is convenient for you.</p>
      ','2015-06-04 11:28:34.276626','2016-02-03 11:52:13.122805','can-i-contact-with-my-radok-testers-team');
    SQL
  end

  def down
    execute(<<-SQL)
      DELETE FROM faq_articles;
    SQL
  end
end
