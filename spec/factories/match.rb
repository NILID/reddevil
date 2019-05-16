FactoryBot.define do
  factory :match do
    association :team1, factory: [:team]
    association :team2, factory: [:team]
    round
  end
end
