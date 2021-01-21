FactoryBot.define do
  factory :manufacture do
    title { "MyTitle" }
    drawing { "MyDrawing" }
    material { "кварц" }
    user { "MyString" }
    machine { "MyMachine" }
    priority { 3 }
    otk_status { "empty" }

    manufacture_group_id { create(:manufacture_group).id }

    factory :manufacture_with_operations do
      transient do
        manufacture_operations_count { 2 }
      end

      after(:create) do |manufacture, evaluator|
        create_list(:manufacture_operation, evaluator.manufacture_operations_count, manufacture: manufacture)
      end
    end
  end
end
