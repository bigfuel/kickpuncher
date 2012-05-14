class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json, :xml

 protected
  def self.helper(*); end # fix for devise

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