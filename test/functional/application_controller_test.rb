require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  describe "#load_project" do
    before do
      @project = Fabricate(:project)
    end

    it "return not found if the project is inactive" do
      @controller = PostsController.new
      lambda { get_with_project @project, :index, format: :json }.must_raise ActionController::RoutingError
      assigns(:project).must_be_nil
    end

    it "return invalid auth_token if the project auth_token is invalid" do
      @project.activate
      @controller = PostsController.new
      lambda { get :index, format: :json, project_id: @project }.must_raise ActionController::RoutingError
      lambda { get :index, format: :json, project_id: @project, auth_token: "Db6eKc4Mk5Fo3Kf9djcp" }.must_raise ActionController::RoutingError
    end

    describe "loading an active project" do
      before do
      @project.activate
        @controller = PostsController.new
        get_with_project @project, :index, format: :json
        @controller_project = assigns(:project)
      end

      it "returns the project" do
        @controller_project.must_equal @project
      end
    end
  end

  describe "project SHOW" do
    it "return a routing error when not_found is called" do
      @controller = ProjectsController.new
      lambda { get :show, id: "" }.must_raise ActionController::RoutingError
    end
  end
end
