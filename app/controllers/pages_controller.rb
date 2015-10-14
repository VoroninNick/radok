class PagesController < ApplicationController
  before_action :set_page_metadata
  before_action :set_page_banner, except: [:home]


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
    @home_slides = [
        {title: "We test mobile, web apps and games.", description: "Professional crowd testing team are ready to start testing your software product immediately", button: { title: "Start now", subtitle: ("no registration required" unless current_user), svg: "rf-rocket-up-right.svg", class: "start-now-button", sref: "wizard", href: wizard_path  } }
    #{title: "We are experienced testers", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Read more", subtitle: "about us", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "about"  } }
    #{title: "Google like us", description: "We working on cool projects for customers from whole world", button: { title: "Find out", subtitle: "about our testing services", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "testing_services"  } }
    ]

    @three_images_in_row_model = [
        {img: "rf-icon-main-1.svg", title: "Tell us what you need to test", time: "Takes less than 10 minutes!", description: "Choose the type of testing you need, amount of hours to be spent, number of people involved and platforms you want your product be tested on. No sign-up or credit card needed."},
        {img:"rf-icon-main-2.svg", title: "Submit your request", time: "2-3 minutes", description: "Submit your request and sit back and enjoy our engineers will do everything else! Our team of 1500+ testing professionals are ready to start immediately."},
        {img: "rf-icon-main-3.svg", title: "Get rapid results", time: "48 hours", description: "Within 48 hours, you will receive a detailed bug report with test cases carefully documented. In some cases we will even get the work done overnight."}
    ]

    @what_for_you = {
        title: "What’s in it for you?",
        items: [
            "Get results fast - in 48 hours!",
            "No time wasted on a bunch of freelancers, each able to test only on a couple of platforms;",
            "Have your product tested on all the needed platforms, don’t miss anything;",
            "You get service only by certified professionals."
        ]
    }

    @statistics = {
        title: "Our software testing statistics",
        tested_projects_count: 300,
        testers_count: 1850
    }

    @feedbacks = [
        {text: "I am very pleased with the capability of Radok Force. I contacted them to get a functional and usability testing before a release of our piece of software. The reports I received were very professional and exceeded my expectations. They also caught a number of bugs we missed internally. Our release was so much smoother thanks to Radok Force.", name: "Victor Shevchenko", position: "Company CEO"},
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
  end

  def devices
    @devices = Wizard::Device.all
  end
end