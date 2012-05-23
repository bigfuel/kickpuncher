class SignupsController < ApplicationController
  include ProjectContextConcern

  def index
    params[:sort_direction] ||= "asc"

    @signups = @project.signups
    @signups = @signups.order_by(params[:sort_column], params[:sort_direction]) if params[:sort_column]
    @signups = @signups.page(params[:page])
    @signups = @signups.per(params[:per_page]) if params[:per_page]

    respond_with @signups
  end

  def show
    @signup = @project.signups.find(params[:id])

    respond_with @signup
  end

  def create
    @signup = @project.signups.new(params[:signup])
    params[:signup].each do |k, v|
      @signup[k] = v unless @signup.respond_to?(k)
    end

    if @signup.save
      @signup.complete if @signup[:opt_out]
    end

    respond_with @signup
  end

  def update
    @signup = @project.signups.find(params[:id])
    @signup.update_attributes(params[:signup])

    respond_with @signup
  end

  def destroy
    @signup = @project.signups.find(params[:id])
    @signup.destroy

    respond_with @signup
  end
end