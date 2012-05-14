Fabricator(:project) do
  name                           { sequence(:project_name) { |i| "project_#{i}" } }
  description                    { Faker::Company.catch_phrase }
  facebook_app_id                "000000000000" # Replace with a real facebook app id
  facebook_app_secret            "00000000000000000000000000000000" # Replace with a real facebook secret
  google_analytics_tracking_code "whyyoutrackin'me"
  production_url                 "https://apps.facebook.com/bf_project_test/"
  auth_token                     "Sb1eEk4M7WFo3K6ysycj"
end