require 'faker'

10.times do |i|
  User.create(email: Faker::Internet.email, name: Faker::Name.name, password: '123456')
end

10.times do |i|
  customer = Customer.create(name: Faker::Name.name, email: Faker::Internet.email)
  writer_1 = Writer.create(name: Faker::Book.author, city: Faker::Address.city, dob:Faker::Date.birthday(18, 65))
  writer_2 = Writer.create(name: Faker::Book.author, city: Faker::Address.city, dob:Faker::Date.birthday(18, 65))
  if i.odd?
    book = Book.create(name: Faker::Book.title, pages: Faker::Number.number(3), leased: true, year: Faker::Date.birthday(1, 30).year, customer_id: customer.id )
    book.writers << [writer_1, writer_2]
  else
    book = Book.create(name: Faker::Book.title, pages: Faker::Number.number(3), leased: true, year: Faker::Date.birthday(1, 30).year )
    book.writers << [writer_1]
  end

end