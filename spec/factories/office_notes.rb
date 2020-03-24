FactoryBot.define do
  factory :office_note do
    num { "180/05-#{Faker::Number.number(digits: 10)}" }
    title { "Making machine" }
    whom { "Dmitry" }
  end
end
