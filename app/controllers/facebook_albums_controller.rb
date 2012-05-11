class FacebookAlbumsController < ApplicationController
  before_filter :load_project, :check_for_project

  def index
    params[:sort_direction] ||= "asc"

    @facebook_albums = @project.facebook_albums
    @facebook_albums = @facebook_albums.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @facebook_albums = @facebook_albums.page(params[:page])
    @facebook_albums = @facebook_albums.per(params[:per_page]) if params[:per_page]

    respond_with @facebook_albums
  end

  def show
    @facebook_album = @project.facebook_albums.find_by_name(params[:id])

    respond_with @facebook_album
  end
end