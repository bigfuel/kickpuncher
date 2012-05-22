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

  def create
    @image = @project.images.new(params[:image])
    @image.save
    respond_with @image
  end

  def update
    @image = @project.images.find(params[:id])
    @image.update_attributes(params[:image])
    respond_with @image
  end

  def destroy
    @image = @project.images.find(params[:id])
    @image.destroy

    respond_with @image
  end

  def approve
    @image = @project.images.find(params[:id])
    @image.approve

    render json: '{ "status":"success" }', status: :ok
  end

  def deny
    @image = @project.images.find(params[:id])
    @image.deny

    render json: '{ "status":"success" }', status: :ok
  end
end