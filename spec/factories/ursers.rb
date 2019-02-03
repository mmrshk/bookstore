FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@email.com" }
    password              {'agent007'}
    password_confirmation {'agent007'}
    confirmed_at          { Time.now }
  end
end
