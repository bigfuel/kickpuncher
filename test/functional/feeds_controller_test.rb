require 'test_helper'

describe FeedsController do
  before do
    @project = load_project
    add_permissions "feeds"
  end

  describe "on GET to :show" do
    it "with a feed name, returns a list of feed entries in json format" do
      skip
    end
  end
end