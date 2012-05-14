require "minitest_helper"

describe "Facebook Albums Integration Test" do
  before do
    @project = Fabricate(:project, name: "bf_project_test")
    @project.activate
  end

  describe "on GET to :index" do
    before do
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680)
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "test_album_2", set_id: 111239835, limit: 11)
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "need_better_names_3", set_id: 9999374293, limit: 12)
    end

    it "retreieve all facebook albums" do
      get "/facebook_albums?project_id=bf_project_test&auth_token=Sb1eEk4M7WFo3K6ysycj&format=json"
      body.size.must_equal 3

      body[0]['name'].must_equal "bf_facebook_album_test"
      body[0]['set_id'].must_equal 1357924680
      body[0]['limit'].must_equal 10

      body[1]['name'].must_equal "test_album_2"
      body[1]['set_id'].must_equal 111239835
      body[1]['limit'].must_equal 11

      body[2]['name'].must_equal "need_better_names_3"
      body[2]['set_id'].must_equal 9999374293
      body[2]['limit'].must_equal 12
    end
  end

  describe "on GET to :show" do
    before do
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680324234)
    end

    it "retrieve correct facebook album" do
      get "/facebook_albums/bf_facebook_album_test?project_id=bf_project_test&auth_token=Sb1eEk4M7WFo3K6ysycj&format=json"

      body['name'].must_equal "bf_facebook_album_test"
      body['set_id'].must_equal 1357924680324234
      body['limit'].must_equal 10
    end
  end

  describe "on POST to :create" do
    it "sucessfully creates a new facebook album" do
      post "/facebook_albums", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_album: { "name" => "bf_facebook_album_test", "set_id" => 46457457324234 }, format: "json" }
      # get "/facebook_albums/bf_facebook_album_test?project_id=bf_project_test&format=json"
      ap body

      body['name'].must_equal "bf_facebook_album_test"
      body['set_id'].must_equal 46457457324234
      body['limit'].must_equal 10
    end
  end

  # describe "on PUT to :update" do
  #   before do
  #     @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680)
  #     visit edit_facebook_album_path(@project, @facebook_album)
  #   end

  #   it "sucessfully update a facebook_album :html" do
  #     page.fill_in "facebook_album_name", with: "new_name"
  #     page.fill_in "facebook_album_set_id", with: "987654321"
  #     page.click_on "Save"
  #     page.must_have_content "Facebook album was successfully updated."
  #     page.must_have_content "987654321"
  #   end

  #   it "sucessfully update a facebook_album :json" do
  #     skip
  #   end

  #   it "fails to update a facebook_album" do
  #     page.fill_in "facebook_album_name", with: ""
  #     page.click_on "Save"
  #     page.must_have_content "prohibited this project from being saved"
  #   end

  #   it "fails to update a facebook_album :json" do
  #     skip
  #   end
  # end

  # describe "on POST to :delete" do
  #   before do
  #     @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test")
  #   end

  #   it "sucessfully deletes a facebook_album :html" do
  #     visit facebook_albums_path(@project)
  #     page.must_have_content "bf_facebook_album_test"
  #     page.click_on "Delete"
  #     visit facebook_albums_path(@project)
  #     page.wont_have_content "bf_facebook_album_test"
  #   end

  #   it "sucessfully deletes a facebook_album :json" do
  #     visit facebook_albums_path(@project)
  #     page.must_have_content "bf_facebook_album_test"
  #     page.driver.delete facebook_album_path(@project, @facebook_album, format: :json)
  #     visit facebook_albums_path(@project)
  #     page.wont_have_content "bf_facebook_album_test"
  #   end
  # end
end