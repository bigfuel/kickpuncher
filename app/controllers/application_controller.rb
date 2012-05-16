class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json, :xml

 protected
  def verify_auth_token
    raise ActionController::RoutingError.new('Invalid auth_token') unless @project.verify_auth_token(params[:auth_token])
  end

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