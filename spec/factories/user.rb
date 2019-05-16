# ROLES = %w(admin user moderator editor test manager)
#              1    2       4       8      16    32

FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.unique.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { DateTime.now }

    after(:build) do |u|
      u.profile = build(:profile)
      u.member = build(:member)
    end

    trait(:admin) do
      after(:create) { |u| u.update_attribute(:roles_mask, 1)}
    end


    trait(:user) do
      after(:create) { |u| u.update_attribute(:roles_mask, 2)}
    end

    trait(:manager) do
      after(:create) { |u| u.update_attribute(:roles_mask, 32)}
    end
  end
end
