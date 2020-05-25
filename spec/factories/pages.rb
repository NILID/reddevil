FactoryBot.define do
  factory :page do
    title { Faker::Lorem.unique.word }
    content { "MyText" }
    # slug { Faker::Lorem.unique.word }
    user
  end
end
