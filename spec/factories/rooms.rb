FactoryBot.define do
  factory :room do
    name { "MyString" }
    private { false }

    trait(:private) { private { true } }
  end
end
