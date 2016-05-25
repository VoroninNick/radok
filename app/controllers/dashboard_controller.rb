class DashboardController < ApplicationController
  before_action :check_user
  before_action :set_project, only: [:project, :project_bug_list, :project_bug]
  before_action :set_project_breadcrumbs, only: [:project, :project_bug_list, :project_bug]

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
    @head_title = "#{@project.try(:project_name)} - Dashboard"
  end

  def project_bug_list
    set_page_metadata("dashboard")
    #set_page_banner
    @bag_list_title = "Bugfix report v2.56"


    add_breadcrumb({text: "Bugfix report 1.0.1", active: true})

    @severities = [:critical, :minor, :major, :normal, :enhancement]

    @bugs = bugs
  end

  def project_bug
    set_page_metadata("dashboard")
    #set_page_banner
    add_breadcrumb({text: "Bugfix report 1.0.1", url: dashboard_project_bug_list_path(@project)})


    @bug = bugs.first
    @bug[:type] = :functional
    @bug[:created_at] = DateTime.now

    add_breadcrumb({text: "Bug ##{@bug[:id]} #{@bug[:title]}", active: true})

  end



  private
  def check_user
    redirect_to new_user_session_path unless current_user
  end

  def set_project
    @project = Wizard::Test.find(params[:project_id]) rescue render_not_found
  end

  def set_project_breadcrumbs
    @breadcrumbs = [{icon: "rocket.svg", url: root_path}, {text: "My dashboard", url: dashboard_path}, {text: @project.project_name, url: dashboard_project_path(@project)} ]
  end

  def add_breadcrumb(b)
    @breadcrumbs << b
  end

  def bugs
    @severity_symbols = {minor: 1, normal: 2, major: 3, critical: {icon: "severity_icons/critical.svg"}, enhancement: 0}
    components = ["Admin console"]
    [
        {id: 1, title: "Bulletin board, projects, resources and activities covering a wide range of Wikipedia areas.2", severity: :major, component: components[0], version: "1.0.1", platform: "Win/IE10", attachments: [], comments: [] },
        {id: 2, title: "Bulletin board, projects, resources and activities covering a wide range of Wikipedia areas.3", severity: :minor, component: components[0], version: "1.0.1", platform: "Win/IE10", attachments: [], comments: []},
        {id: 3, title: "Bulletin board, projects, resources and activities covering a wide range of Wikipedia areas.4", severity: :normal, component: components[0], version: "1.0.1", platform: "Win/IE10", attachments: [], comments: []},
        {id: 4, title: "Bulletin board, projects, resources and activities covering a wide range of Wikipedia areas.5", severity: :enhancement, component: components[0], version: "1.0.1", platform: "Win/IE10", attachments: [], comments: []},
        {id: 5, title: "Bulletin board, projects, resources and activities covering a wide range of Wikipedia areas.1", severity: :critical, component: components[0], version: "1.0.1", platform: "Win/IE10", attachments: [], comments: []}
    ]
  end
end
