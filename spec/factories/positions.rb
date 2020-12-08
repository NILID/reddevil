FactoryBot.define do
  factory :position do
    position { "MyString" }
    moved_at { "2020-12-04" }
    member
    department
  end
end
