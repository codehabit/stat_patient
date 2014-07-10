require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def wrlog arg
  STDOUT.print arg
end

delete_all = true
dentist_file = 'app/assets/data/iowa_dentists_specialists.csv'
force_valid_email = true
cases_per_practitioner = 20
messages_per_case = 6
user_count = 100
patient_count = 1000
specialties = Specialty.all.map(&:pretty)
birthday_day_range = (1092..32850).to_a
marital_status = MaritalStatus.all

bad_count = 0
good_count = 0


if delete_all
  wrlog 'Deleting all'
  User.delete_all
  Practitioner.delete_all
  Patient.delete_all
  Case.delete_all
  Message.delete_all
end

wrlog "\n"

defpass = 'stat.1234'
practitioners = []

# make the demo users
User.create(first_name: 'Bob', last_name: 'Onesto', email: 'ronesto@gmail.com', password: defpass, password_confirmation: defpass)
User.create(first_name: 'Robb', last_name: 'Broome', email: 'robb@codehabit.net', password: defpass, password_confirmation: defpass)
User.create(first_name: 'David', last_name: 'Oliver', email: 'david.oliver@codehabit.net', password: defpass, password_confirmation: defpass)
User.create(first_name: 'Alex', last_name: 'Leach', email: 'alex@codehabit.net', password: defpass, password_confirmation: defpass)

wrlog 'Creating Patients'
patients = patient_count.times.map do
  offset = birthday_day_range.sample
  birthday = offset.days.ago
  wrlog '.'
  Patient.create(
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

wrlog "\n"
if dentist_file.present?
  wrlog "Making dentists from file #{dentist_file}"
  CSV.foreach(dentist_file, headers: true) do |row|
    password = Faker::Internet.password(9)
    user = User.create(first_name: row['first_name'], last_name: row['last_name'], email: row['email1'], password: password, password_confirmation: password)
    if !user.valid? && force_valid_email
      user.update_attributes(email: Faker::Internet.safe_email)
      user.save
    end
    if user.valid?
      practitioners << Practitioner.create(user_id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, specialty: row['specialty'], phone: row['phone_work'])
      good_count += 1
      wrlog '.'
    else
      bad_count += 1
      wrlog 'x'
    end

  end

else
  wrlog "Making dentists randomly"
  user_count.times.map do
    password = Faker::Internet.password(9)
    User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.safe_email, password: password, password_confirmation: password)
    wrlog '.'
  end
end

wrlog "\n"

User.all.each do |user|
  next if user.practitioner.present?
  wrlog "making a practitioner for #{user.full_name} \n"
  practitioners << Practitioner.create(user_id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, specialty: specialties.sample, phone: Faker::PhoneNumber.cell_phone)
end


wrlog "Making Cases"
practitioners.each  do |practitioner|
  case_count = (2..cases_per_practitioner).to_a.sample
  case_count.times do
    wrlog 'c'

    originator = practitioner
    recipient = (practitioners - [originator]).sample
    patient = patients.sample
    addrs = [originator, recipient]
    sender, receiver = addrs
newcase = Case.create originator: originator, recipient: recipient, patient: patient, subject: Faker::Lorem.sentence, notes: Faker::Lorem.paragraph
    message_count = (1..messages_per_case).to_a.sample
    message_count.times do
      wrlog 'm'
      Message.create case_id: newcase.id, sender: sender, recipient: receiver, body: Faker::Lorem.sentence
      sender, receiver = addrs.reverse!
    end
  end
end
wrlog "\n Done"
wrlog "\n #{good_count} dentist records were created"
wrlog "\n #{bad_count} dentist records were rejected"
