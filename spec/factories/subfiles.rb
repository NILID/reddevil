FactoryBot.define do
  factory :subfile do
    src { Rack::Test::UploadedFile.new('spec/factories/files/ru.png', 'image.png') }
    substrate
    user
  end
end
