class VideosController < ApplicationController
  before_filter :load_project, :check_for_project

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
end