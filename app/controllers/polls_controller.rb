class PollsController < ApplicationController
  before_filter :load_project, :check_for_project, :verify_auth_token

  def index
    params[:sort_direction] ||= "asc"

    @polls = @project.polls
    @polls = @polls.where(state: params[:state]) if params[:state]
    @polls = @polls.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @polls = @polls.page(params[:page])
    @polls = @polls.per(params[:per_page]) if params[:per_page]

    respond_with @polls
  end

  def vote
    poll = @project.polls.active.find(params[:id])
    poll.vote(params['choice']['id'])

    respond_with @poll
  end

  def show
    @poll = @project.polls.find(params[:id])

    respond_with @poll
  end

  def create
    @poll = @project.polls.new(params[:poll])
    @poll.save
    respond_with @poll
  end

  def update
    @poll = @project.polls.find(params[:id])
    @poll.update_attributes(params[:poll])
    respond_with @poll
  end

  def destroy
    @poll = @project.polls.find(params[:id])
    @poll.destroy

    respond_with @poll
  end

  def activate
    @poll = @project.polls.find(params[:id])
    @poll.activate

    render json: '{ "status":"success" }', status: :ok
  end

  def deactivate
    @poll = @project.polls.find(params[:id])
    @poll.deactivate

    render json: '{ "status":"success" }', status: :ok
  end
end
