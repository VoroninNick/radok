class DashboardController < ApplicationController
  before_action :check_user

  def index
    user_tests = current_user.tests
    @drafts = user_tests.drafts

    @in_progress_tests = user_tests.processing_projects

    @finished_projects = user_tests.tested_projects

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

  def check_user
    if !current_user
      redirect_to new_user_session_path
    end
  end
end