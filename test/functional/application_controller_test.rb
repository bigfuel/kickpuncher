require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  describe "#load_project" do
    before do
      @project = Fabricate(:project)
      @controller = PostsController.new
      add_permissions "posts"
    end

    it "return not found if the project is inactive" do
      lambda { get_with_project @project, :index, format: :json }.must_raise ActionController::RoutingError
      assigns(:project).must_be_nil
    end

    describe "loading an active project" do
      before do
        @project.activate
        @controller = PostsController.new
        add_permissions "posts"
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
