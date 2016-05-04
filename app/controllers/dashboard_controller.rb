class DashboardController < ApplicationController
  before_action :check_user
  before_action :set_page_banner, only: [:index, :project]

  def index
    user_tests = current_user.tests
    @drafts = user_tests.drafts
    @unpaid = user_tests.unpaid_projects
    @in_progress_tests = user_tests.processing_projects
    @finished_projects = user_tests.tested_projects
    a = @finished_projects.to_a
    if a.any?
      @finished_projects_groups = a.each_slice((a.size/2.to_f).round).to_a
    end
    set_page_metadata('dashboard')
  end

  def project
    @project = Wizard::Test.find(params[:id]) rescue render_not_found
    @head_title = "#{@project.try(:project_name)} - Dashboard"
  end

  def check_user
    redirect_to new_user_session_path unless current_user
  end

  def set_page_banner
    @banner = Banner.find(2)
    super
  end
end
