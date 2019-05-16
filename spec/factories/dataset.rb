FactoryBot.define do
  factory :dataset do
    title { Faker::Lorem.unique.word }
    src   { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png')) }
    folder
    user
  end
end
