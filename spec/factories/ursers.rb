FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@email.com" }
    password { 'agent007' }
    after(:build) { |user| user.class.skip_callback(:save, :before) }
  end
end
