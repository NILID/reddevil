FactoryBot.define do
  factory :vacation do
    startdate { Faker::Date.backward(5) }
    enddate   { Faker::Date.forward(5) }
    member
  end
end
