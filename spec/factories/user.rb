# ROLES = %w(admin user moderator editor testuser manager guest)
#              1    2       4       8      16      32      64

# GROUPS = %w[luch lab193 test lab182]
#               1    2     4     8

FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.unique.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { DateTime.now }

    after(:build) do |u|
      u.profile = build(:profile)
      u.member  = build(:member)
    end

    trait(:admin) do
      after(:create) { |u| u.update_attribute(:roles_mask, 1)}
    end

    trait(:user) do
      after(:create) { |u| u.update_attribute(:roles_mask, 2)}
    end

    trait(:moderator) do
      after(:create) { |u| u.update_attribute(:roles_mask, 4)}
    end

    trait(:testuser) do
      after(:create) { |u| u.update_attribute(:roles_mask, 16)}
    end

    trait(:manager) do
      after(:create) { |u| u.update_attribute(:roles_mask, 32)}
    end

    trait(:from_lab) do
      after(:create) { |u| u.update_attribute(:groups_mask, 2)}
    end

    trait(:from_lab182) do
      after(:create) { |u| u.update_attribute(:groups_mask, 8)}
    end
  end
end
