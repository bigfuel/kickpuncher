require 'test_helper'

describe "Projects Integration Test" do
  before do
    @project = Fabricate(:project, name: "bf_project_test")
  end

  it "shows project's name" do
    get project_path(@project)
    page.text.must_include "bf_project_test"
  end
end