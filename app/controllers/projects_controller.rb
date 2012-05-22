class ProjectsController < ApplicationController
  def index
    @projects = Project.order_by("name", "asc").page(params[:page])
    respond_with @projects
  end

  def show
    @project = Project.find_by_name(params[:id])
    respond_with @project
  end

  def deauthorize
    render nothing: true
  end

  def create
    @project = Project.new(params[:project])
    @project.save
    respond_with @project
  end

  def update
    @project = Project.find_by_name(params[:id])
    @project.update_attributes(params[:project])
    respond_with @project
  end

  def destroy
    @project = Project.find_by_name(params[:id])
    @project.destroy

    respond_with @project
  end

  def activate
    @project = Project.find_by_name(params[:id])
    @project.activate

    render json: '{ "status":"success" }', status: :ok
  end

  def deactivate
    @project = Project.find_by_name(params[:id])
    @project.deactivate

    render json: '{ "status":"success" }', status: :ok
  end

  protected
  def decode_signed_request(signed_request, app_id, app_secret)
    if signed_request
      oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
      return oauth.parse_signed_request(signed_request)
    end
  end

  def get_access_token
    oauth = Koala::Facebook::OAuth.new(@project.facebook_app_id, @project.facebook_app_secret)
    oauth.get_app_access_token
  end
end