FactoryBot.define do
  factory :page do
    temp = Faker::Lorem.unique.word
    title { temp }
    content { "MyText" }
    slug { temp }
    user
  end
end
