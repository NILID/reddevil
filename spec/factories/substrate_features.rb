FactoryBot.define do
  factory :substrate_feature do
    length { 1 }
    sign { "equals" }
    feature { 1.5 }
    substrate
  end
end