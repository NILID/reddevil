FactoryBot.define do
  factory :column do
    name { 'Name of column' }
    column_type { 'boolean' }
    table
  end
end
