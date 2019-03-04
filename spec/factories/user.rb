# ROLES = %w(admin user moderator editor test drawing mirrors manager)
#              1    2       4       8      16    32      64     128

FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.unique.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { DateTime.now }

    after(:build) { |u| u.profile = build(:profile) }

    trait(:admin) do
      after(:create) { |u| u.update_attribute(:roles_mask, 1)}
    end


    trait(:user) do
      after(:create) { |u| u.update_attribute(:roles_mask, 2)}
    end

    trait(:manager) do
      after(:create) { |u| u.update_attribute(:roles_mask, 128)}
    end
  end
end
