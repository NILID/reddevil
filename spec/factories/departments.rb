FactoryBot.define do
  factory :department do
    title { Faker::Lorem.unique.word }
  end
end
