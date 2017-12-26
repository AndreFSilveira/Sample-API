FactoryGirl.define do
  factory :book do
    name Faker::Book.title
    pages Faker::Number.number(3)
    leased false
    year Faker::Date.birthday(18, 65).year
  end
  factory :book_leased do
    name Faker::Book.title
    pages Faker::Number.number(3)
    leased true
    year Faker::Date.birthday(18, 65).year
    association :customer, factory: :customer
  end
end