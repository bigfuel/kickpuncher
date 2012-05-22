require 'test_helper'

describe ProjectsController do
  describe "loaded project" do
    before do
      @project = Fabricate(:project, name: "fp_test")
    end

    it "return a routing error if the project is inactive" do
      lambda { get :show, id: @project }.must_raise ActionController::RoutingError
    end

    it "load the first matching active project" do
      @project.activate
      get :show, id: @project
      @controller_project = assigns(:project)
      @controller_project.wont_be nil
      @controller_project.name.must_equal 'fp_test'
    end
  end
end