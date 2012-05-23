module AuthorizationConcern
  extend ActiveSupport::Concern

  included do
    before_filter :check_permission
  end

  protected
  def check_permission
    raise ActionController::RoutingError.new('Not authorized to access this resource') unless @project.has_permission?(controller_name, action_name)
  end
end