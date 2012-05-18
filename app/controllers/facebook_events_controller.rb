class FacebookEventsController < ApplicationController
  before_filter :load_project, :check_for_project, :verify_auth_token

  def index
    params[:sort_direction] ||= "asc"

    @facebook_events = @project.facebook_events
    @facebook_events = @facebook_events.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @facebook_events = @facebook_events.page(params[:page])
    @facebook_events = @facebook_events.per(params[:per_page]) if params[:per_page]

    respond_with @facebook_events
  end

  def show
    @facebook_event = @project.facebook_events.find_by_name(params[:id])

    respond_with @facebook_event, responder: Responders
  end

  def create
    @facebook_event = @project.facebook_events.new(params[:facebook_event])
    @facebook_event.save

    respond_with @facebook_event
  end

  def update
    @facebook_event = @project.facebook_events.find_by_name(params[:id])
    @facebook_event.update_attributes(params[:facebook_event])

    respond_with @facebook_event, responder: Responders
  end

  def destroy
    @facebook_event = @project.facebook_events.find_by_name(params[:id])
    @facebook_event.destroy

    respond_with @facebook_event, responder: Responders
  end
end