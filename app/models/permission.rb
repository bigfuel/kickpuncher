class Permission
  include Mongoid::Document
  field :controller_name, type: String
  field :action_name, type: String

  validates :controller_name, presence: true
  validates :action_name, presence: true
  validate :valid_controller_and_action_name

  attr_accessible :controller_name, :action_name
  cattr_reader :routes

  embedded_in :project

  def valid_controller_and_action_name
    unless Permission.routes[controller_name].include?(action_name)
      errors.add(:controller_name, "does not have the '#{action_name}' action")
      errors.add(:action_name, "action for the '#{controller_name}' controller does not exist")
    end
  end

  def self.routes
    @@routes ||= begin
      routes = Hash.new
      Rails.application.routes.routes.map do |route|
        next unless route.defaults[:controller]
        controller_name = route.defaults[:controller]
        routes[controller_name] = Set.new unless routes.has_key?(controller_name)
        routes[controller_name] << route.defaults[:action]
      end
      routes
    end
  end

  def self.controller_names
    self.routes.keys
  end
end
