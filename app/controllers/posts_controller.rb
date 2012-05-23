class PostsController < ApplicationController
  include ProjectContextConcern

  def index
    params[:sort_direction] ||= "asc"

    @posts = @project.posts
    @posts = @posts.where(state: params[:state]) if params[:state]
    @posts = @posts.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @posts = @posts.has_images if params[:has_images]
    @posts = @posts.tags_tagged_with(params[:tags]) if params[:tags]
    @posts = @posts.page(params[:page])
    @posts = @posts.per(params[:per_page]) if params[:per_page]

    respond_with @posts
  end

  def show
    @post = @project.posts.find(params[:id])

    respond_with @post
  end

  def create
    @post = @project.posts.new(params[:post])
    @post.save
    respond_with @post
  end

  def update
    @post = @project.posts.find(params[:id])
    @post.update_attributes(params[:post])
    respond_with @post
  end

  def destroy
    @post = @project.posts.find(params[:id])
    @post.destroy

    respond_with @post
  end

  def approve
    @post = @project.posts.find(params[:id])
    @post.approve

    render json: '{ "status":"success" }', status: :ok
  end

  def deny
    @post = @project.posts.find(params[:id])
    @post.deny

    render json: '{ "status":"success" }', status: :ok
  end
end
