FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.free_email
    password_digest Faker::Internet.password(8)
  end
end