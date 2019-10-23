FactoryBot.define do
  factory :room do
    name { "MyString" }
    private { false }
    user

    trait(:private) { private { true } }
  end
end
