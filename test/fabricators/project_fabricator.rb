Fabricator(:project) do
  name                           { sequence(:project_name) { |i| "project_#{i}" } }
  description                    { Faker::Company.catch_phrase }
  facebook_app_id                "000000000000" # Replace with a real facebook app id
  facebook_app_secret            "00000000000000000000000000000000" # Replace with a real facebook secret
  google_analytics_tracking_code "whyyoutrackin'me"
  production_url                 "https://apps.facebook.com/bf_project_test/"
  # after_build do |project|
  #   Rails.application.routes.routes.map do |route|
  #     project.permissions << Fabricate.build(:permission, controller_name: route.defaults[:controller], action_name: route.defaults[:action]) if route.defaults[:controller] && route.defaults[:action]
  #   end
  # end
end