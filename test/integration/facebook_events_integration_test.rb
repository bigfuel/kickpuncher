require 'test_helper'

describe "Facebook Events Integration Test" do
  before do
    @project = Fabricate(:project, name: "bf_project_test")
    @project.activate
  end

  describe "GET :index" do
    before do
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "bf_facebook_event_test")
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "test_event_2", limit: 11)
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "need_better_names_3", limit: 12)
    end

    it "retrieves all facebook events" do
      get "/facebook_events", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json"}

      events = JSON.parse(last_response.body)
      assert events.size.must_equal 3

      assert events[0]['name'].must_equal "bf_facebook_event_test"
      assert events[0]['limit'].must_equal 10

      assert events[1]['name'].must_equal "test_event_2"
      assert events[1]['limit'].must_equal 11

      assert events[2]['name'].must_equal "need_better_names_3"
      assert events[2]['limit'].must_equal 12

      assert last_response.status.must_equal 200
    end
  end

  describe "GET :show" do
    before do
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "bf_facebook_event_test")
    end

    it "retrieve a facebook event" do
      get "/facebook_events/bf_facebook_event_test", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json"}

      event = JSON.parse(last_response.body)
      event['name'].must_equal "bf_facebook_event_test"
      event['limit'].must_equal 10

      assert last_response.status.must_equal 200
    end

    it "throws an error if event is not found" do
      get "/facebook_events/doesnt_exist", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json"}

      response = JSON.parse(last_response.body)
      response['error']['status'].must_equal "404"
      response['error']['message'].must_equal "Sorry, couldn't find resource"

      assert last_response.status.must_equal 404
    end
  end

  describe "POST :create" do
    before do
      post "/facebook_events", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_event: { name: "bf_facebook_event_test" }, format: "json" }
    end

    it "sucessfully creates a new facebook event" do
      event = JSON.parse(last_response.body)
      event['name'].must_equal "bf_facebook_event_test"
      event['limit'].must_equal 10

      assert last_response.status.must_equal 201
    end

    it "throws an error if the event already exist" do
      post "/facebook_events", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_event: { name: "bf_facebook_event_test" }, format: "json" }

      event = JSON.parse(last_response.body)
      event['errors']['name'][0].must_equal "has already been used in this project."

      assert last_response.status.must_equal 422
    end
  end

  describe "PUT :update" do
    before do
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "bf_facebook_event_test", limit: 25)
    end

    it "sucessfully updates a facebook event" do
      put "/facebook_events/bf_facebook_event_test", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", facebook_event: { name: "new_facebook_event_test", limit: 15 }, format: "json" }

      event = JSON.parse(last_response.body)
      event['name'].must_equal "new_facebook_event_test"
      event['limit'].must_equal 15

      assert last_response.status.must_equal 200
    end
  end

  describe "DELETE :destroy" do
    before do
      @facebook_event = Fabricate(:facebook_event, project: @project, name: "some_new_event")
    end

    it "sucessfully deletes a facebook event" do
      delete "/facebook_events/some_new_event", { project_id: "bf_project_test", auth_token: "Sb1eEk4M7WFo3K6ysycj", format: "json" }

      response = JSON.parse(last_response.body)
      response['delete']['status'].must_equal "200"
      response['delete']['message'].must_equal "the resource has been deleted"

      assert last_response.status.must_equal 200
    end
  end
end