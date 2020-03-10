FactoryBot.define do
  factory :vacation do
    startdate { Faker::Date.backward(days: 5) }
    enddate   { Faker::Date.forward(days: 5) }
    flag      { 'rest' }
    member
  end
end
