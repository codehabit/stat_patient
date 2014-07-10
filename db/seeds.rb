# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cases_per_practitioner = 30
messages_per_case = 30
user_count = 40
patient_count = 100
specialties = Specialty.all.map(&:pretty)
birthday_day_range = (1092..260988).to_a
marital_status = MaritalStatus.all

delete_all = true

if delete_all
  User.delete_all
  Practitioner.delete_all
  Patient.delete_all
  Case.delete_all
  Message.delete_all
end

defpass = 'stat.1234'
demo_users = [
  User.create(first_name: 'Bob', last_name: 'Onesto', email: 'ronesto@gmail.com', password: defpass, password_confirmation: defpass),
  User.create(first_name: 'Robb', last_name: 'Broome', email: 'robb@codehabit.net', password: defpass, password_confirmation: defpass),
  User.create(first_name: 'David', last_name: 'Oliver', email: 'david.oliver@codehabit.net', password: defpass, password_confirmation: defpass),
  User.create(first_name: 'Ales', last_name: 'Leach', email: 'alex@codehabit.net', password: defpass, password_confirmation: defpass)
]

patients = patient_count.times.map do
  offset = birthday_day_range.sample
  birthday = offset.days.ago
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    date_of_birth: birthday ,
    email: Faker::Internet.safe_email,
    home_phone: Faker::PhoneNumber.phone_number,
    work_phone: Faker::PhoneNumber.phone_number,
    mobile_phone: Faker::PhoneNumber.phone_number,
    gender: ['male', 'female'].sample,
    marital_status: marital_status.sample,
    street: Faker::Address.street_address,
    street2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip_code,
    social_security_number: '1111111111'
  )

end


users = user_count.times.map do
  password = Faker::Internet.password(9)
  user = User.create first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.safe_email, password: password, password_confirmation: password
end

users += demo_users

practitioners = []
users.each do |user|
  practitioners << Practitioner.create(user_id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, specialty: specialties.sample, phone: Faker::PhoneNumber.cell_phone)
end

practitioners.each  do |practitioner|
  case_count = (2..cases_per_practitioner).to_a.sample
  case_count.times do

    originator = practitioner
    recipient = (practitioners - [originator]).sample
    patient = patients.sample
    addrs = [originator, recipient]
    sender, receiver = addrs
newcase = Case.create originator: originator, recipient: recipient, patient: patient, subject: Faker::Lorem.sentence, notes: Faker::Lorem.paragraph
    message_count = (1..messages_per_case).to_a.sample
    message_count.times do
      Message.create case_id: newcase.id, sender: sender, recipient: receiver, body: Faker::Lorem.sentence
      sender, receiver = addrs.reverse!
    end
  end
end

