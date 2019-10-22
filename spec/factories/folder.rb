FactoryBot.define do
  factory :folder do
    title { Faker::Lorem.unique.word }
    user
  end
end
