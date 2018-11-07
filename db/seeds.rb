# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
zip_range = (29_601..29_699).to_a
zip_range.each do |zip|
  Location.create(
    zip_code: zip
  )
end
User.create(
  name: Faker::Name.name,
  company_name: 'Top Notch Plumbing',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '18645675685'
)
User.create(
  name: Faker::Name.name,
  company_name: 'Water Works Inc.',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '18432511462'
)
User.create(
  name: Faker::Name.name,
  company_name: 'Slick Willy Plumbing',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '18434650504'
)
User.create(
  name: Faker::Name.name,
  company_name: 'Howard Plumbing Co.',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '18642701430'
)
User.create(
  name: Faker::Name.name,
  company_name: 'Simpson Family Plumbing',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '18649017949'
)
User.create(
  name: Faker::Name.name,
  company_name: 'Phillips & Phillips Plumbers',
  email: Faker::Internet.email,
  password: 'password1',
  vendor: true,
  Phone_Number: '17047289266'
)

User.all.each do |user|
  10.times do
    location = Location.all.sample
    user.locations << location
  end
end
