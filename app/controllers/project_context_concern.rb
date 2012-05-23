module ProjectContextConcern
  extend ActiveSupport::Concern

  included do
    before_filter :load_project, :check_for_project
  end

  protected
  def check_for_project
    not_found unless @project
  end

  def load_project
    @project = Project.active.find_by_name(params[:project_id])
  end
end