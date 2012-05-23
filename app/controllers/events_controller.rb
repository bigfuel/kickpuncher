class EventsController < ApplicationController
  include ProjectContextConcern
  include AuthorizationConcern

  def index
    params[:sort_direction] ||= "asc"

    @events = @project.events
    @events = @events.where(state: params[:state]) if params[:state]
    @events = @events.any_in(type: params[:type].split(",")) if params[:type]
    @events = @events.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @events = @events.page(params[:page])
    @events = @events.per(params[:per_page]) if params[:per_page]

    respond_with @events
  end

  def show
    @event = @project.events.find(params[:id])

    respond_with @event
  end

  def create
    @event = @project.events.new(params[:event])
    @event.move_to_top if @event.save

    respond_with @event
  end

  def update
    @event = @project.events.find(params[:id])
    @event.update_attributes(params[:event])
    respond_with @event
  end

  def destroy
    @event = @project.events.find(params[:id])
    @event.destroy
    respond_with @event
  end

  def approve
    @event = @project.events.find(params[:id])
    @event.approve

    respond_with @event do |format|
      format.html { redirect_to [:admin, @project, @event] }
      format.json { render json: '{ "status":"success" }', status: :ok }
    end
  end

  def deny
    @event = @project.events.find(params[:id])
    @event.deny

    render json: '{ "status":"success" }',  status: :ok
  end

  def import
    logger.debug params[:file].open
    CSV.parse(params[:file].open, {headers: true}) do |row|
      @project.events.create!(name: row['name'], type: row['type'], start_date: Date.strptime(row['start_date'], '%m/%d/%Y'), end_date: Date.strptime(row['end_date'], '%m/%d/%Y'), url: row['url'], details: row['details'], location: Location.new(name: row['location.name'], address: row['location.address'], latitude: row['location.latitude'] || 0, longitude: row['location.longitude'] || 0))
    end
    render json: '{ "status":"success" }',  status: :ok
  end
end
