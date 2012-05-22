class SubmissionsController < ApplicationController
  before_filter :load_project, :check_for_project, :verify_auth_token

  def index
    params[:sort_direction] ||= "asc"

    @submissions = @project.submissions
    @submissions = @submissions.where(state: params[:state]) if params[:state]
    @submissions = @submissions.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @submissions = @submissions.page(params[:page])
    @submissions = @submissions.per(params[:per_page]) if params[:per_page]

    respond_with @submissions
  end

  def show
    @submission = @project.submissions.find(params[:id])

    respond_with @submission
  end

  def create
    @submission = @project.submissions.new(params[:submission])
    @submission.save

    respond_with @submission
  end

  def update
    @submission = @project.submissions.find(params[:id])
    @submission.update_attributes(params[:submission])

    respond_with @submission
  end

  def destroy
    @submission = @project.submissions.find(params[:id])
    @submission.destroy

    respond_with @submission
  end

  def approve
    @submission = @project.submissions.find(params[:id])
    @submission.approve

    render json: '{ "status":"success" }', status: :ok
  end

  def deny
    @submission = @project.submissions.find(params[:id])
    @submission.deny

    render json: '{ "status":"success" }', status: :ok
  end
end