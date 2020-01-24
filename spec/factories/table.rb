FactoryBot.define do
  factory :table do
    title { Faker::Lorem.unique.word }
  end
end
