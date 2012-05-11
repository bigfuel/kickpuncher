class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  protected
  def check_for_project
    not_found unless @project
  end

  def load_project
    @project = Project.active.find_by_name(params[:project_id])
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end