class ProjectsController < ApplicationController
  
  layout 'with_small_header'
  
  def create
    project = Project.new(project_params)
    if project.save
      redirect_to project
    else
      redirect_to root_path, alert: project.errors.full_messages.last
    end
  end

  def show
    @project = Project.find_by(username:  params[:username], name: params[:repo])
  end

  def random
    project = Project.order("RAND()").first
    redirect_to project_path(project.username, project.name)
  end

  private
    def project_params
      params.require(:project).permit(:github_url)
    end
end