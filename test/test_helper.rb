require 'simplecov'
SimpleCov.start 'rails'
require 'minitest/matchers'
require 'mocha'
require 'turn'
require 'rack/test'

# Uncomment if you want awesome colorful output
# require "minitest/pride"
Turn.config.format = :outline

ENV["RAILS_ENV"] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include ValidAttribute::Method

  def setup
    DatabaseCleaner.start
    Rails.cache.clear
  end

  def teardown
    DatabaseCleaner.clean
    Rails.cache.clear
  end
end

class ActionController::TestCase
  def load_project
    project = Fabricate.build(:project, name: 'bf_project_test')
    Project.stubs(active: stub(find_by_name: project))
    project
  end

  def json_response
    ActiveSupport::JSON.decode @response.body
  end

  def get_with_project(project, action, parameters = {}, session = nil, flash = nil)
    parameters = merge_project_parameters(parameters, project)
    get(action, parameters, session, flash)
  end

  def post_with_project(project, action, parameters = {}, session = nil, flash = nil)
    parameters = merge_project_parameters(parameters, project)
    post(action, parameters, session, flash)
  end

  def put_with_project(project, action, parameters = {}, session = nil, flash = nil)
    parameters = merge_project_parameters(parameters, project)
    put(action, parameters, session, flash)
  end

  def delete_with_project(project, action, parameters = {}, session = nil, flash = nil)
    parameters = merge_project_parameters(parameters, project)
    delete(action, parameters, session, flash)
  end

  def head_with_project(project, action, parameters = {}, session = nil, flash = nil)
    parameters = merge_project_parameters(parameters, project)
    head(action, parameters, session, flash)
  end

  private
  def merge_project_parameters(parameters, project)
    parameters.reverse_merge(project_id: project.name, auth_token: project.authentication_token)
  end
end

class ActionDispatch::IntegrationTest
  include Rack::Test::Methods
end
