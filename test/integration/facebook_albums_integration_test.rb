require "minitest_helper"

describe "Facebook Albums Integration Test" do
  before do
    @project = Fabricate(:project, name: "bf_project_test")
    @project.activate
  end

  describe "GET :index" do
    before do
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680)
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "test_album_2", set_id: 111239835, limit: 11)
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "need_better_names_3", set_id: 9999374293, limit: 12)
    end

    it "retrieves all facebook albums" do
      get "/facebook_albums", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json"}

      albums = JSON.parse(last_response.body)
      assert albums.size.must_equal 3

      assert albums[0]['name'].must_equal "bf_facebook_album_test"
      assert albums[0]['set_id'].must_equal 1357924680
      assert albums[0]['limit'].must_equal 10

      assert albums[1]['name'].must_equal "test_album_2"
      assert albums[1]['set_id'].must_equal 111239835
      assert albums[1]['limit'].must_equal 11

      assert albums[2]['name'].must_equal "need_better_names_3"
      assert albums[2]['set_id'].must_equal 9999374293
      assert albums[2]['limit'].must_equal 12

      assert last_response.status.must_equal 200
    end
  end

  describe "GET :show" do
    before do
      @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680324234)
    end

    it "retrieve a facebook album" do
      get "/facebook_albums/bf_facebook_album_test", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json"}

      album = JSON.parse(last_response.body)
      album['name'].must_equal "bf_facebook_album_test"
      album['set_id'].must_equal 1357924680324234
      album['limit'].must_equal 10

      assert last_response.status.must_equal 200
    end

    it "throws an error if album doesn't exist" do
      skip
    end
  end

  describe "POST :create" do
    before do
      post "/facebook_albums", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_album: { "name" => "bf_facebook_album_test", "set_id" => 46457457324234 }, format: "json" }
    end

    it "sucessfully creates a new facebook album" do
      album = JSON.parse(last_response.body)
      album['name'].must_equal "bf_facebook_album_test"
      album['set_id'].must_equal 46457457324234
      album['limit'].must_equal 10

      assert last_response.status.must_equal 201
    end

    it "throws an error if the album already exist" do
      post "/facebook_albums", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_album: { "name" => "bf_facebook_album_test", "set_id" => 1357924680324234 }, format: "json" }

      album = JSON.parse(last_response.body)
      album['errors']['name'][0].must_equal "has already been used in this project."

      assert last_response.status.must_equal 422
    end
  end

  # describe "PUT :update" do
  #   before do
  #     @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test", set_id: 1357924680, limit: 25)
  #   end

  #   it "sucessfully updates a facebook album" do
  #     put "/facebook_albums", { project_id: "bf_project_test", facebook_album: { "name" => "new_facebook_album_test", "set_id" => 939337488 }, format: "json" }
  #     ap JSON.parse(last_response.body)
  #   end

  #   it "throws an error if updating a facebook album fails" do
  #     skip
  #   end
  # end

  # describe "POST :delete" do
  #   before do
  #     @facebook_album = Fabricate(:facebook_album, project: @project, name: "bf_facebook_album_test")
  #   end

  #   it "sucessfully deletes a facebook album" do
  #     skip
  #   end
  # end
end