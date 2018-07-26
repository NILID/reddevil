FactoryBot.define do
  factory :note do
    content 'Some note text'

    trait(:with_screenshot) { screenshot Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png')) }
  end
end
