class ProjectsController < ApplicationController
  respond_to :json, :xml

  def index
    @projects = Project.all
    respond_with @projects
  end

  def show
    @project = Project.last
    # @signed_request = decode_signed_request(params[:signed_request], @project.facebook_app_id, @project.facebook_app_secret)
    # @liked = @signed_request['page']['liked'] rescue false
    # @liked = true if Rails.env.development?

    if Rails.env.development? || stale?(etag: [@project, params[:signed_request]], last_modified: @project.updated_at.utc, public: true)
      respond_with @project
    end
  end

  def deauthorize
    render nothing: true
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