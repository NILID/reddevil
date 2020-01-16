FactoryBot.define do
  factory :doc do
    title { 'Category one' }
    file  { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png')) }
  end
end
