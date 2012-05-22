require 'test_helper'

describe PollsController do
  before do
    @project = load_project
  end

  describe "on GET to :index" do
    before do
      @polls = []
      3.times do
        poll = Fabricate(:poll, project: @project)
        poll.activate
        @polls << poll
      end
    end

    it "return a list of active polls" do
      get_with_project @project, :index, format: :json
      must_respond_with :success
      must_render_template "polls/index"
      polls = assigns(:polls)
      polls.must_equal @polls
    end
  end

  describe "on GET to :show" do
    before do
      @poll = Fabricate(:poll, project: @project)
      @poll.activate
      get_with_project @project, :show, format: :json, id: @poll.id
    end

    it "returns a poll object" do
      must_respond_with :success
      poll = assigns(:poll)
      poll.must_equal @poll
    end
  end

  describe "on GET to :vote" do
    before do
      @poll = Fabricate(:poll, project: @project)
      @poll.activate
    end

    it "with a valid poll" do
      put_with_project @project, :vote, format: :json, id: @poll.id, choice: { id: @poll.choices.first }
      must_respond_with :success
    end

    it "with a blank choice should return a validation error" do
      put_with_project @project, :vote, format: :json, id: @poll.id, choice: { id: "" }
      must_respond_with :unprocessable_entity
    end

    it "with a nonexistant choice should return a validation error" do
      put_with_project @project, :vote, format: :json, id: @poll.id, choice: { id: "400000000000000000000000" }
      must_respond_with :unprocessable_entity
    end
  end

  describe "on POST to :create" do
    it "with an invalid poll, will return the poll with error validations " do
      post_with_project @project, :create, format: :json, poll: Poll.new
      must_respond_with :unprocessable_entity
      json_response["errors"]["question"].must_include "can't be blank"
    end

    it "with a valid poll will return an poll" do
      poll = Fabricate.attributes_for(:poll, question: "Drink the fuel?", project: @project)
      post_with_project @project, :create, format: :json, poll: poll
      must_respond_with :success
      json_response['question'].must_equal "Drink the fuel?"
    end
  end
end