class VideosController < ApplicationController
  before_filter :load_project, :check_for_project, :verify_auth_token

  def index
    params[:sort_direction] ||= "asc"

    @videos = @project.videos
    @videos = @videos.where(state: params[:state]) if params[:state]
    @videos = @videos.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @videos = @videos.page(params[:page])
    @videos = @videos.per(params[:per_page]) if params[:per_page]

    respond_with @videos
  end

  def show
    @video = @project.videos.find(params[:id])

    respond_with @video
  end

  def create
    @video = @project.videos.new(params[:video])
    @video.save

    respond_with @video
  end

  def update
    @video = @project.videos.find(params[:id])
    @video.update_attributes(params[:video])

    respond_with @video
  end

  def destroy
    @video = @project.videos.find(params[:id])
    @video.destroy

    respond_with @video
  end

  def approve
    @video = @project.videos.find(params[:id])
    @video.approve

    render json: '{ "status":"success" }', status: :ok
  end

  def deny
    @video = @project.videos.find(params[:id])
    @video.deny

    render json: '{ "status":"success" }', status: :ok
  end
end