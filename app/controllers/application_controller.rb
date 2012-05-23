class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

 protected
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end