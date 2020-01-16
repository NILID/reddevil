FactoryBot.define do
  factory :card do
    title { "MyString" }
    category
    trait :with_doc do
      doc { fixture_file_upload(Rails.root.join('spec/factories/files/ru.png'), 'image/png') }
    end
  end
end
