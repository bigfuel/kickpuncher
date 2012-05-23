class FeedsController < ApplicationController
  include ProjectContextConcern

  def index
    params[:sort_direction] ||= "asc"

    @feeds = @project.feeds
    @feeds = @feeds.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @feeds = @feeds.page(params[:page])
    @feeds = @feeds.per(params[:per_page]) if params[:per_page]

    respond_with @feeds
  end

  def show
    @feed = @project.feeds.find_by_name(params[:id])

    respond_with @feed
  end

  def create
    @feed = @project.feeds.new(params[:feed])
    @feed.save
    respond_with @feed
  end

  def update
    @feed = @project.feeds.find_by_name(params[:id])
    @feed.update_attributes(params[:feed])

    respond_with @feed
  end

  def destroy
    @feed = @project.feeds.find_by_name(params[:id])
    @feed.destroy

    respond_with @feed
  end
end