FactoryBot.define do
  factory :member do
    name         { Faker::Name.first_name }
    surname      { Faker::Name.middle_name }
    patronymic   { Faker::Name.last_name }
    birth        { Faker::Date.birthday(min_age: 18, max_age: 70) }
    phone        { Faker::PhoneNumber.subscriber_number(length: 8) }
    short_number { Faker::PhoneNumber.subscriber_number(length: 4) }
    work_phone   { Faker::PhoneNumber.subscriber_number(length: 4) }
    email        { Faker::Internet.unique.email }
    department
  end
end
