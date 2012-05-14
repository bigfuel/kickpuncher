class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json, :xml

  protected
  def check_for_project
    not_found unless @project
  end

  def load_project
    @project = Project.active.find_by_name_and_auth_token(params[:project_id], params[:auth_token])
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end