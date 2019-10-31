FactoryBot.define do
  factory :substrate do
    title { "MyTitle" }
    drawing { "MyDrawing" }
    detail { "MyDetail" }
    amount { 1 }
    contract { "MyContract" }
    arrival_at { "2019-10-24 13:06:50" }
    arrival_from { "MyArrival From" }
    shipping_at { "2019-10-24 13:06:50" }
    shipping_to { "MyString" }
    shipping_base { "MyText" }
    status { "MyString" }
    user
  end
end
