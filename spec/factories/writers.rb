FactoryGirl.define do
  factory :writer do
    name Faker::Name.name
    city Faker::Address.city
    dob Faker::Date.birthday(18, 65)
  end
end