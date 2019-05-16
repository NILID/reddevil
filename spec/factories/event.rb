FactoryBot.define do
  factory :event do
    title { 'event one' }
    content { 'about event' }
    user
  end
end
