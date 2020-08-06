FactoryBot.define do
  factory :department do
    title { Faker::Company.unique.name }
  end
end
