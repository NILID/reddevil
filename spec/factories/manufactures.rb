FactoryBot.define do
  factory :manufacture do
    title { "MyTitle" }
    drawing { "MyDrawing" }
    contract { "MyContract" }
    material { "кварц" }
    user { "MyString" }
    machine { "MyMachine" }
    operation { "MyOperation" }
    priority { 4 }
    otk_status { "empty" }
  end
end
