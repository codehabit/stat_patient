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

drugs_only = false

delete_all = true
dentist_file = 'data/iowa_dentists_specialists.csv'
drugs_file = 'data/drugs_list.csv'
force_valid_email = true
force_safe_email = true
cases_per_practitioner = (1..2).to_a
messages_per_case = (2..3).to_a
system_age_range_days = (10..720)
today = Date.today
user_count = 100
patient_count = 100
specialties = Specialty.all.map(&:pretty)
birthday_day_range = (1092..32850).to_a
marital_status = MaritalStatus.all

random = Random.new

bad_count = 0
good_count = 0


unless drugs_only
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
  User.create(first_name: 'David', last_name: 'Oliver', email: 'david@codehabit.net', password: defpass, password_confirmation: defpass)
  User.create(first_name: 'Alex', last_name: 'Leach', email: 'alex@codehabit.net', password: defpass, password_confirmation: defpass)

  wrlog 'Creating Patients'
  patients = []
  ActiveRecord::Base.transaction do
    patient_count.times.map do
      offset = birthday_day_range.sample
      birthday = offset.days.ago
      wrlog '.'
      patient = Patient.create(
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
      age_days = random.rand(system_age_range_days)
      create_date = age_days.days.ago
      patient.update_attribute :created_at, create_date

      patients << patient

    end
  end

  wrlog "\n"
  if dentist_file.present?
    wrlog "Making dentists from file #{dentist_file}"
    ActiveRecord::Base.transaction do
      CSV.foreach(dentist_file, headers: true) do |row|
        next if row['first_name'].blank? || row['last_name'].blank?
        password = Faker::Internet.password(9)
        user_email = force_safe_email  ? Faker::Internet.safe_email : row['email1']
        user = User.create(first_name: row['first_name'], last_name: row['last_name'], email: user_email, password: password, password_confirmation: password)
        if !user.valid? && force_valid_email
          # just ignore if this fails because of unique constraint. That's rare.
          user.update_attribute(:email, Faker::Internet.safe_email) rescue nil
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
    ActiveRecord::Base.transaction do
      case_count = cases_per_practitioner.sample
      case_count.times do
        wrlog 'c'
        patient = patients.sample
        patient_age_days = (today - patient.created_at.to_date).to_i
        case_create_date = patient_age_days.days.ago

        originator = practitioner
        recipient = (practitioners - [originator]).sample
        addrs = [originator, recipient]
        sender, receiver = addrs
        newcase = Case.create originator: originator, recipient: recipient, patient: patient, subject: Faker::Lorem.sentence, notes: Faker::Lorem.paragraph
        newcase.update_attribute :created_at, case_create_date

        message_count = messages_per_case.sample
        message_count.times do
          wrlog 'm'
          message = Message.create case_id: newcase.id, sender: sender, recipient: receiver, body: Faker::Lorem.sentence
          message_age_days = random.rand(1..patient_age_days)
          message.update_attribute :created_at, message_age_days.days.ago

          sender, receiver = addrs.reverse!
        end
      end
    end
    wrlog ' | '
  end
end

Drug.delete_all
Organization.delete_all
PrescriptionOrder.delete_all

wrlog "\n Make drugs"
ActiveRecord::Base.transaction do
  drug_names = []
  CSV.foreach(drugs_file, headers: false) do |row|
    next if row[0].blank?
    name = row[0].split('- ').first
    drug_names << name
  end
  drug_names.each do |drug|
    Drug.create name: drug, dispense_amount: '4 tabs', dispense_frequency: 'Twice per day', 
      uuid: SecureRandom.uuid, adult_dosing: '4 pills twice per day', peds_dosing: '1 pill twice per day', contraindications: 'None known', 
      pharmacy_instructions: Faker::Lorem.sentence(3), patient_instructions: Faker::Lorem.sentence(3)
    wrlog drug
  end
end

wrlog "\n Make orgs"
org_types = %w(pharmacy laboratory practice)
ActiveRecord::Base.transaction do
  300.times.map do |t|
    wrlog '.'
    Organization.create name: Faker::Company.name, organization_type: org_types.sample
  end
end

patient_count = Patient.count
practitioner_count = Practitioner.count
drug_count = Drug.count
pharmacy_count = Pharmacy.count

drugs = Drug.all
pharmacies = Pharmacy.all

wrlog "\n Make prescriptions"
ActiveRecord::Base.transaction do
  Patient.all.each do |patient|
    practitioner = patient.practitioners.sample
    pharmacy = pharmacies.sample
    drug = drugs.sample

    rx  = PrescriptionOrder.create rx_id: SecureRandom.uuid, practitioner: practitioner, patient: patient, drug: drug, pharmacy: pharmacy
    rx.update_attribute :created_at, patient.created_at
    wrlog '.'
  end
end

wrlog "\n Done"
wrlog "\n #{good_count} dentist records were created"
wrlog "\n #{bad_count} dentist records were rejected"
