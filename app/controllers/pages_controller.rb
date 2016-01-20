class PagesController < ApplicationController
  before_action :set_page_metadata
  before_action :set_page_banner, except: [:home, :robots_txt]


  def self.actions
    self.instance_methods.sort - self.superclass.instance_methods - %w(default set_page_metadata).map(&:to_sym)
  end

  def default
    initial_template = params[:initial_template]
    if template_exists?(initial_template)
      render initial_template
    end
  end

  def pricing
    #render "static_html/pricing"
    render "default"
  end

  def how_it_works
    #render "static_html/how_it_works"
    render "default"
  end

  def testing_services
    #render "static_html/testing_services"
    render "default"
  end

  def about

    #render "static_html/about"
    render "default"
  end



  def home
    #return render inline: session.keys.inspect
    @home_slides = [
        {images: ["/assets/radok-web-banner-layer-1.png", "/assets/radok-web-banner-layer-2.png", "/assets/radok-web-banner-layer-3.png"], title: "We test mobile, web apps and games.", description: "Professional crowd testing team are ready to start testing your software product immediately", button: { title: "Start now", subtitle: ("no registration required" unless current_user), svg: "rf-rocket-up-right.svg", class: "start-now-button", sref: "wizard", href: wizard_path  } },
        {images: ["/assets/banners/2/radok-web-banner2-layer-1.png", "/assets/banners/2/radok-web-banner2-layer-2b.png", "/assets/banners/2/radok-web-banner2-layer-3b.png"], title: "We have a bunch of different devices to test on", description: "Professional crowd testing team are ready to start testing your software product immediately", button: { title: "Check out", svg: "rf-rocket-up-right.svg", class: "start-now-button", sref: "wizard", href: devices_path  } }
    #{title: "We are experienced testers", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Read more", subtitle: "about us", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "about"  } }
    #{title: "Google like us", description: "We working on cool projects for customers from whole world", button: { title: "Find out", subtitle: "about our testing services", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "testing_services"  } }
    ]

    @three_images_in_row_model = [
        {img: "rf-icon-main-1.svg", title: "Tell us what you need to test", time: "Takes less than 10 minutes!", description: "Choose the type of testing you need, amount of hours to be spent, number of people involved and platforms you want your product be tested on. No sign-up or credit card required."},
        {img:"rf-icon-main-2.svg", title: "Submit your request", time: "2-3 minutes", description: "Submit your request and our engineers will do the rest! So sit back and relax our team of 1500+ testing professionals are ready to start immediately."},
        {img: "rf-icon-main-3.svg", title: "Get rapid results", time: "48 hours", description: "In no more than 48 hours, you will receive a detailed bug report with your carefully documented test cases. If you need results faster, please contact us and we will try to accomdate your request."}
    ]

    @what_for_you = {
        title: "What’s in it for you?",
        items: [
            "Fast - get results in 48 hours or less!",
            "Comprehensive - have your product tested on every platform you require!",
            "Professional - With us , your application is reviewed only by certified professionals with years of industry experience.",
            "Your time is used wisely - not wasted on freelancers, who are only able to test only on a couple of platforms at a time."
        ]
    }

    @statistics = {
        title: "Our software testing statistics",
        tested_projects_count: 300,
        testers_count: 1850
    }

    @feedbacks = [
        {text: "I am very pleased with the capability of 10G-Force. I contacted them to get a functional and usability testing before a release of our piece of software. The reports I received were very professional and exceeded my expectations. They also caught a number of bugs we missed internally. Our release was so much smoother thanks to 10G-Force.", name: "Victor Shevchenko", position: "Company CEO"},
        {text: "We have involved 10G-Force in testing our mobile app for localisation. We all at [company name] were impressed with the testing team’s in-depth knowledge and system approach. Besides, we got results in less than 2 days! Without any hesitation, we are going to use 10G-Force services again in the future."},
        {text: "I have engaged with 10G-Force after a few failed attempts to work with cheap freelancers. I was disappointed no one could test my app on all the devices I needed, both desktop and mobile, so didn’t even expect they could do this in such a short period. Not only my app was tested on all the platforms and devices I asked, but also I got a profound report with the recommendations for bug fixing to make my app truly responsive. I’m planning to use Radok Force in all further iterations and product pivots as it is worry-free for me. "}
    ]

    @who_we_are_best_for = {
        title: "Who we work best with:",
        items: [
            "startups that need to test their products before a release",
            "product companies that don’t have in-house QA engineers",
            "product owners or individual freelancers"
        ]
    }

    @benefits = {
        title: "Benefits:",
        items: [
            "We deliver results in 48 hours!",
            "1500+ professional certified QA engineers;",
            "we test on all platforms, (we have access to every hardware device manufactured in the last 5 years);",
            "We are available to support our customers 24/7."
        ]
    }


    @show_plans_section_header = true

    #flash[:anonymous_test_ids] = [458, 459, 460]
  end

  def devices
    @devices = Wizard::Device.all

    @statistics = {
        title: "Devices in numbers",
        devices_count: 109,
        manufacturers_count: 21,
        operating_systems: 48,
        screen_sizes: 25
    }
  end

  def robots_txt
    render template: "pages/robots.txt"
  end
end