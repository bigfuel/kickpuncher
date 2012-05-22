require 'test_helper'

describe SubmissionsController do
  before do
    @project = load_project
  end

  describe "on GET to :show" do
    before do
      @submission = Fabricate(:submission, project: @project)
      @submission.approve
    end

    it "return a submission" do
      get_with_project @project, :show, format: :json, id: @submission.id
      must_respond_with :success
      must_render_template "api/submissions/show"
      submission = assigns(:submission)
      submission.must_equal @submission
    end
  end

  describe "on POST to :create" do
    it "with a valid submission, return the saved submission" do
      submission = Fabricate.attributes_for(:submission, facebook_id: '310', project: nil)
      submission['photo'] = Rack::Test::UploadedFile.new(Rails.root.join('test', 'support', 'Desktop.jpg').to_s, 'image/jpeg', true)
      post_with_project @project, :create, format: :json, submission: submission
      must_respond_with :success
      json_response['facebook_id'].must_equal '310'
    end

    it "on invalid submission, return submission with validation errors" do
      post_with_project @project, :create, format: :json, submission: Submission.new
      must_respond_with :unprocessable_entity
      json_response["errors"]["facebook_name"].must_include "can't be blank"
    end
  end
end