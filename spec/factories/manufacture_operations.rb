FactoryBot.define do
  factory :manufacture_operation do
    started_at { "2020-12-25" }
    finished_at { "2020-12-25" }
    manufacture
    operation
    member
  end
end
