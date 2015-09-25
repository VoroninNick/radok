class HomeController < ApplicationController
  def index
    # @how_it_works_items = [
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"},
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"},
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"}
    # ]

    #render file: Rails.root.join("app/assets/templates/home.html"), layout: false

    #@title = "Home page"

    #@template = "/assets/home.html"

    #render template: "layouts/ng", layout: false


    @home_slides = [
      {title: "We test mobile, web apps, and games.", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Start now", subtitle: ("no registration required" unless current_user), svg: "rf-rocket-up-right.svg", class: "start-now-button", sref: "wizard", href: "/wizard"  } }
      #{title: "We are experienced testers", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Read more", subtitle: "about us", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "about"  } }
      #{title: "Google like us", description: "We working on cool projects for customers from whole world", button: { title: "Find out", subtitle: "about our testing services", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "testing_services"  } }
    ]

    @three_images_in_row_model = [
      {img: "rf-icon-main-1.svg", title: "Tell us that you need to test", time: "Takes less than 10 minutes!", description: "Choose the type of testing you need, amount of hours spent, number of people involved, and platforms you want your product be tested on. No sign-up or credit card needed."},
      {img:"rf-icon-main-2.svg", title: "Submit your request", time: "2-3 minutes", description: "Submit your request and sit back enjoying our engineers do everything else! Our team of 1500+ testing professionals are ready to start immediately."},
      {img: "rf-icon-main-3.svg", title: "Get rapid results", time: "48 hours", description: "In up to 48 hours, you will receive a detailed bug report with test cases carefully documented. In some cases, we would even get the work done overnight."}
    ]

    @what_for_you = {
      title: "What’s in it for you?",
      items: [
        "Get results fast - in 48 hours!",
        "No time wasted on a bunch of freelancers, each able to test only on a couple of platforms;",
        "Have your product tested on all the needed platforms, don’t miss anything;",
        "You get a service only by certified professionals."
      ]
    }

    @statistics = {
      title: "Need some statistic?",
      tested_projects_count: 300,
      testers_count: 1850
    }

    @feedbacks = [
      {text: "I am greatly pleased with the experience with Radok Force. I have contacted them to get a functional and usability testing before a release of our peace of software. The reports guys created were very professional and did exceed my expectations, and also they caught a number of bugs we missed internally. Our release was so much smoother thanks to Radok Force.", name: "Victor Shevchenko", position: "Company CEO"},
      {text: "We have involved Radok in testing our mobile app for localisation. We all at [company name] were impressed with the testing team’s in-depth knowledge and system approach. Besides, we got results in less than 2 days! Without any hesitation, we are going to use Radok’s services in the future."},
      {text: "I have engaged with Radok Force after a few failed attempts to work with cheap freelancers on oDesk. I was disappointed no one could test my app on all the devices I needed, both desktop and mobile, so didn’t even expect they could do this in such a short period. Not only my app was tested on all the platforms and devices I asked, but also I got a profound report with the recommendations for bug fixing to make my app truly responsive. I’m planning to use Radok Force in all further iterations and product pivots as it is worry-free for me. "}
    ]

    @who_we_are_best_for = {
      title: "Who we are best for:",
      items: [
        "Startups that need to test their products before a release;",
        "Product companies that don’t have QA engineers in-house;",
        "Product owners or individual freelancers to test their product."
      ]
    }

    @benefits = {
      title: "Benefits:",
      items: [
        "We deliver results in 48 hours!",
        "1500+ professional certified QA engineers;",
        "we test on all platforms, we mean it, all (we have access to every hardware device manufactured in the last 5 years);",
        "our customers support works 24/7."
      ]
    }

    @show_plans_section_header = true

    render
  end

  def about

    @template = "/assets/about.html"

    @title = "About us page"

    render template: "layouts/ng", layout: false
  end

  def contact
    @template = "/assets/contact.html"

    @title = "Contact us page"

    render template: "layouts/ng", layout: false
  end


  def svg_images
    file_paths = Dir[Rails.root.join("app/assets/images/*.svg")]
    file_data = file_paths.map do |file_path|
      comp = File.basename(file_path)
      extn = File.extname(file_path)
      name = File.basename(file_path, extn)

      file_content = File.read(file_path)
      doc = Nokogiri::HTML::DocumentFragment.parse file_content
      res = res = doc.to_html

      compressor = HtmlCompressor::Compressor.new
      compressed = compressor.compress(res)
      compressed_without_xml_dtd = compressed.sub(/<\?xml.*\?>/, '')



      {content: compressed_without_xml_dtd, file_path: name}
    end

    render inline: file_data.to_json

  end
end
