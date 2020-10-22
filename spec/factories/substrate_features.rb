FactoryBot.define do
  factory :substrate_feature do
    sign { "equals" }
    feature { 1.5 }
    litera { 'R' }
    length { '180..190' }
    substrate
  end
end
