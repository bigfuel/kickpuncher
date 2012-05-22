require 'test_helper'

describe ImagesController do
  before do
    @project = load_project
  end

  describe "on GET to :index" do
    before do
      @images = []
      3.times do
        @images << Fabricate(:image, project: @project)
      end
    end

    it "return a list of images" do
      get_with_project @project, :index, format: :json
      must_respond_with :success
      must_render_template "api/images/index"
      images = assigns(:images)
      (images - @images).must_be_empty
    end
  end

  describe "on GET to :show" do
    before do
      @image = Fabricate(:image, project: @project)
    end

    it "return an image" do
      get_with_project @project, :show, format: :json, id: @image.id
      must_respond_with :success
      must_render_template "api/images/show"
      image = assigns(:image)
      image.must_equal @image
    end
  end

  describe "on POST to :create" do
    it "with an invalid image, will return the image with error validations " do
      post_with_project @project, :create, format: :json, image: Image.new
      must_respond_with :unprocessable_entity
      json_response["errors"]["image"].must_include "can't be blank"
    end

    it "with a valid image will return an image" do
      image = Fabricate.attributes_for(:image, name: "logo", project: nil)
      image['image'] = Rack::Test::UploadedFile.new(Rails.root.join('test', 'support', 'Desktop.jpg').to_s, 'image/jpeg', true)
      post_with_project @project, :create, format: :json, image: image
      must_respond_with :success
      json_response['name'].must_equal "logo"
    end
  end
end