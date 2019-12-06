FactoryBot.define do
  factory :substrate do
    title { "MyTitle" }
    # sequence(:drawing) { Faker::Lorem.unique.word }
    detail { "MyDetail" }
    amount { 1 }
    contract { "MyContract" }
    arrival_at { "2019-10-24 13:06:50" }
    arrival_from { "MyArrival From" }
    priorityx { 4 }
    shipping_at { "2019-10-24 13:06:50" }
    shipping_to { "MyString" }
    shipping_base { "MyText" }
    statuses_mask { 0 }
    user
  end
end
