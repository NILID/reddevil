FactoryBot.define do
  factory :member do
    name         { Faker::Name.first_name }
    surname      { Faker::Name.middle_name }
    patronymic   { Faker::Name.last_name }
    birth        { Faker::Date.birthday(18, 70) }
    phone        { Faker::PhoneNumber.subscriber_number(8) }
    short_number { Faker::PhoneNumber.subscriber_number(4) }
    work_phone   { Faker::PhoneNumber.subscriber_number(4) }
    email        { Faker::Internet.unique.email }
  end
end
