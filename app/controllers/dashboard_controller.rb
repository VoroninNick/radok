class DashboardController < ApplicationController
  def index
    @drafts = Wizard::Test.all

    @in_progress_tests = Wizard::Test.all

    @finished_projects = Wizard::Test.all

    a = @finished_projects.to_a

    @finished_projects_groups = a.each_slice( (a.size/2.to_f).round ).to_a

    set_page_metadata("dashboard")
  end

  def project
    @project = Wizard::Test.last
  end
end