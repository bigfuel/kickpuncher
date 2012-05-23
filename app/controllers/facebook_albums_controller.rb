class FacebookAlbumsController < ApplicationController
  include ProjectContextConcern

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

    respond_with @facebook_album, responder: Responders
  end

  def create
    @facebook_album = @project.facebook_albums.new(params[:facebook_album])
    @facebook_album.save

    respond_with @facebook_album
  end

  def update
    @facebook_album = @project.facebook_albums.find_by_name(params[:id])
    @facebook_album.update_attributes(params[:facebook_album])

    respond_with @facebook_album, responder: Responders
  end

  def destroy
    @facebook_album = @project.facebook_albums.find_by_name(params[:id])
    @facebook_album.destroy

    respond_with @facebook_album, responder: Responders
  end
end