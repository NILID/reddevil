FactoryBot.define do
  factory :manufacture_group do
    title { "MyString" }
    contract { "MyContract" }
    limit_at { "2021-01-21" }
    actual { false }
  end
end
