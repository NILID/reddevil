FactoryBot.define do
  factory :subfile do
    src { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png')) }
    substrate
    user
  end
end
