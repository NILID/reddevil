FactoryBot.define do
  factory :forecast do
    team1goal { 1 }
    team2goal { 2 }
    user
    match
    association :winner, factory: [:team]
  end
end
