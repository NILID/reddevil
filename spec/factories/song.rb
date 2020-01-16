FactoryBot.define do
  factory :song do
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png')) }
    album
  end
end
