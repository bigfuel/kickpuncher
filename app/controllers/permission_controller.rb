class PermissionController < ApplicationController
  include ProjectContextConcern

  def index
    @permissions = @project.permissions

    respond_with @permissions
  end

  def show
    @permission = @project.permissions.find(params[:id])

    respond_with @permission
  end

  def create
    @permission = @project.permissions.new(params[:permission])
    @permission.save

    respond_with @permission
  end

  def update
    @permission = @project.permissions.find(params[:id])
    @permission.update_attributes(params[:permission])

    respond_with @permission
  end

  def destroy
    @permission = @project.permissions.find(params[:id])
    @permission.destroy

    respond_with @permission
  end
end
