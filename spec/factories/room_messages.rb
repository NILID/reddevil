FactoryBot.define do
  factory :room_message do
    room
    user
    message { "MyText" }
  end
end
