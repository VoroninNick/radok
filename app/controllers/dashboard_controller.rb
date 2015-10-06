class DashboardController < ApplicationController
  def index
    @drafts = Wizard::Test.drafts

    @in_progress_tests = Wizard::Test.processing_projects

    @finished_projects = Wizard::Test.tested_projects

    a = @finished_projects.to_a


    if a.any?
      @finished_projects_groups = a.each_slice( (a.size/2.to_f).round ).to_a
    end

    set_page_metadata("dashboard")
    set_page_banner
  end

  def project
    @project = Wizard::Test.last
  end
end