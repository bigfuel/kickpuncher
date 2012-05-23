Fabricator(:poll) do
  question   { Faker::Lorem.sentence }
  start_date "2011-05-05"
  end_date   "2012-05-05"
  after_build { |poll| poll.choices << Fabricate.build(:choice) }
  project
end