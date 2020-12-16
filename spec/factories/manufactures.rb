FactoryBot.define do
  factory :manufacture do
    title { "MyTitle" }
    drawing { "MyDrawing" }
    contract { "MyContract" }
    material { "кварц" }
    user { "MyString" }
    machine { "MyMachine" }
    operation { "MyOperation" }
    priority { "MyPriority" }
    otk_status { "empty" }
  end
end
