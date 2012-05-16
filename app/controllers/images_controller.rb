class ImagesController < ApplicationController
  before_filter :load_project, :check_for_project, :verify_auth_token

  def index
    params[:sort_direction] ||= "asc"

    @images = @project.images
    @images = @images.where(state: params[:state]) if params[:state]
    @images = @images.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @images = @images.page(params[:page])
    @images = @images.per(params[:per_page]) if params[:per_page]

    respond_with @images
  end

  def show
    @image = @project.images.find(params[:id])

    respond_with @image
  end
end