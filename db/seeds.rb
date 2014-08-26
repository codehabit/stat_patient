require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def dentist_limit; 100; end

def make_dentists_from_file dentist_file, use_real_email = false
  wrlog "Making dentists and practices from file #{dentist_file}"
  wrlog "\n"
  practitioners = []
  count = 0
  ActiveRecord::Base.transaction do
    CSV.foreach(dentist_file, headers: true) do |row|
      count += 1
      break if count > dentist_limit

      next if invalid_data(row)

      pw = row['password'] || password
      user = User.create(email: user_email(row, use_real_email), first_name: row['first_name'], last_name: row['last_name'], password: pw, password_confirmation: pw)

      if !user.valid?
        # just ignore if this fails because of unique constraint, because it's rare
        user.update_attribute(:email, user_email(row, use_real_email)) rescue nil
      end

      if user.valid?
        practitioner = create_practitioner(user, row)
        practitioners << practitioner

        %w(Practice Laboratory Pharmacy).each  do |kind|
          practice = create_org(row, kind)
          practice.members << practitioner
          5.times do
            practice.members << create_practitioner(user)
          end

          practice.save
        end
        wrlog '.'

      else
        wrlog 'x'

      end
    end
  end
  practitioners
end

def force_safe_email; true; end

def dea_check_digit number
  # assume that everyone getting this is a practitioner (i.e., a doctor) (for now)
  odds, evens, count = [0,0,1]
  number.each_char do |digit|
    evens += digit.to_i if count.even?
    odds += digit.to_i if count.odd?
    count += 1
  end
  (evens + odds).to_s.last
end

def update_dea_identifier practitioner
  number = Faker::Number.number(6)
 practitioner.update_attribute(:dea_identifier, "A#{practitioner.last_name[0]}#{number}#{dea_check_digit(number)}")
end

def helper
  @helper ||= ActionController::Base.helpers
end

def filler(range = (20..40))
  Faker::Lorem.sentence(random.rand(range))
end

def pluralize(amt, thing)
  helper.pluralize(amt, thing)
end

def random
  @random ||= Random.new
end

def wrlog arg
  STDOUT.print arg
end

def password
  Faker::Internet.password(9)
end

def invalid_data row
 row['first_name'].blank? || row['last_name'].blank?
end

def user_email row, use_real = false
  if use_real
    row['email1']
  else
    force_safe_email ? Faker::Internet.safe_email : row['email1']
  end
end

def create_practitioner user, row = nil
  if row.present?
    attrs = {first_name: user.first_name, last_name: user.last_name, salutation: row['salutation'], suffix: row['suffix'], title: row['title'], specialty: row['specialty']}
  else
    attrs = {first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, salutation: 'Mr.', suffix: 'DDS', title: '', specialty: 'Cosmetic'}
    user = User.create email: Faker::Internet.safe_email, first_name: attrs[:first_name], last_name: attrs[:last_name] rescue nil
  end

  return unless user.present?
  practitioner = Practitioner.create(attrs.merge(user_id: user.id))
  update_dea_identifier practitioner

  user.update_attribute( :practitioner, practitioner)

  practitioner
end

def kinds
  @kinds ||= {'Practice' => 'Dental', 'Laboratory' => 'Manufacturing', 'Pharmacy' => 'Pharmaceutical'}
end
def create_org row, type
  # todo: check for previous existance
  name = row['office'].gsub('Dental', kinds[type])
  attrs = {name: name, national_provider_identifier: Faker::Number.number(10)}
  org = type.classify.constantize.send(:create, attrs)
  org.addresses <<  Address.create(street1: row['primary_address_street'], city: row['primary_address_city'], state: row['primary_address_state'], postal_code: row['primary_address_postalcode'])

  contacts= {work_phone: row['phone_work'], work_fax: row['phone_fax'], mobile_phone: row['phone_mobile'], email: row['email1'], website: row['website']}

  contacts.each do |type, info|
    next if info.blank?
    org.contacts << Contact.create(contact_type: type.to_s, info: info)
  end
  org.save
  org.reload
end


def instructions
  type = %w(tabs liquid).sample
  hits = random.rand(1..4)
  dose = ['mg', 'mcg'].sample
  dose_hits = random.rand(4..20)
  times = random.rand(1..3)
  frequency = [1,2,3,4,6,8,12].sample

  if type == 'tabs'
    amt = [10, 12, 15, 24, 30, 45, 60].sample
    unit = ['pill', 'capsule'].sample

    dispense = [pluralize(amt, unit)].sample


    instr = ["#{pluralize(hits, unit)}  #{pluralize(times, 'time')} per day.",
      "#{pluralize(hits, unit)} every #{pluralize(frequency, 'hour')}."].sample
    dose_instr = ["#{dose_hits} #{dose}  #{pluralize(times, 'time')} per day.",
      "#{dose_hits} #{dose} every #{pluralize(frequency, 'hour')}."].sample
    dose_instr_pd = ["#{dose_hits} #{dose}  #{pluralize(times, 'time')} per day.",
      "#{dose_hits} #{dose} every #{pluralize(frequency, 'hour')}."].sample
    {
      disp: dispense,
      rx_instructions: "Take #{instr}",
      dose_ad: dose_instr,
      dose_pd: dose_instr_pd,
    }
  elsif type == 'liquid'
    quant = [4, 6, 8, 10, 12, 16, 32].sample
    dispense = [pluralize(quant, 'ounce')].sample
    unit = %w(teaspoon tablespoon).sample
    instr = ["#{pluralize(hits, unit)}  #{pluralize(times, 'time')} per day.",
      "#{pluralize(hits, unit)} every #{pluralize(frequency, 'hour')}."].sample
    dose_instr = ["#{dose_hits} #{dose}  #{pluralize(times, 'time')} per day.",
      "#{dose_hits} #{dose} every #{pluralize(frequency, 'hour')}."].sample
    dose_instr_pd = ["#{dose_hits} #{ dose}  #{pluralize(times, 'time')} per day.",
      "#{dose_hits} #{ dose} every #{pluralize(frequency, 'hour')}."].sample
    {
      disp: dispense,
      rx_instructions: "Take #{instr}",
      dose_ad: dose_instr,
      dose_pd: dose_instr_pd,
    }
  end

end


make_drugs  = true
make_dentists = true

delete_all = true
dentist_file = 'data/iowa_dentists_specialists.csv'
demo_user_file = 'data/demo_users.csv'
drug_files = ['data/drugs/statpatient_drug_formulary.csv']


cases_per_practitioner = (1..2).to_a
messages_per_case = (2..3).to_a
system_age_range_days = (10..720)
today = Date.today
user_count = 100
patient_count = 100
organization_count = 300
specialties = Specialty.all.map(&:pretty)
birthday_day_range = (1092..32850).to_a
marital_status = MaritalStatus.values


if make_dentists
  if delete_all
    wrlog 'Deleting all dentists'
    User.delete_all
    Organization.delete_all
    Practitioner.delete_all
    Patient.delete_all
    Case.delete_all
    Message.delete_all
  end

  wrlog "\n"


  # wrlog "\n Make #{organization_count} pharmacies and labs"
  # wrlog "\n"
  # ActiveRecord::Base.transaction do
  #   organization_count.times.map do |t|
  #     wrlog '.'
  #     Laboratory.create name: Faker::Company.name
  #   end
  #   organization_count.times.map do |t|
  #     wrlog '.'
  #     Pharmacy.create name: Faker::Company.name
  #   end
  # end
  wrlog "Creating #{patient_count} Patients"
  wrlog "\n"
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

  practitioners = []
  wrlog "\n"
  # practitioners << make_dentists_from_file(dentist_file)
  practitioners << make_dentists_from_file(demo_user_file, true)

  wrlog "\n"
  wrlog "Making Cases"
  wrlog "\n"

  Practitioner.all.each  do |practitioner|
    ActiveRecord::Base.transaction do
      case_count = cases_per_practitioner.sample
      case_count.times do
        wrlog 'c'
        patient = patients.sample
        patient_age_days = (today - patient.created_at.to_date).to_i
        case_create_date = patient_age_days.days.ago

        originator = practitioner
        recipient = Practitioner.limit(1).order("RANDOM()").first
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
  Case.all.each do |c|
    latest_message = c.messages.order("created_at DESC").first
    c.update last_activity_date: latest_message.created_at
  end
end

if make_drugs
  if delete_all
    wrlog "\n Delete all drugs and Rx"
    Drug.delete_all
    PrescriptionOrder.delete_all
    DrugDiagnosisAssignment.delete_all
  end

  wrlog "\n Make drugs and Rx"
  drug_files.each do |drug_file|
    ActiveRecord::Base.transaction do
      CSV.foreach(drug_file, headers: true) do |row|

        drug = Drug.create name: row["name"], regimen: row["regimen"], category: row["category"], dea_schedule: row["dea_schedule"],  strength: row["strength"], dosage_form: row["dosage_form"], dispense_amount: row["dispense_amount"], uuid: SecureRandom.uuid, sig: row["sig"], instructions_precautions: row["instructions_precautions"], pregnancy_lactating_precautions: row["pregnancy_lactating_precautions"], contraindications: row["contraindications"], interactions: row["interactions"]

        wrlog "Drug.."
        diagnosis_ids = row["diagnosis_ids"]

        if diagnosis_ids.present?
          diagnosis_ids.split(',').each do |diagnosis_id|
            DrugDiagnosisAssignment.create drug_uuid: drug.uuid, diagnosis_id: diagnosis_id
            wrlog diagnosis_id
            wrlog '.'
          end
        end

      end
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
      practitioner = patient.reload.practitioners.sample
      # patient may not have a case, therefor no practitioner
      next unless practitioner
      practice = practitioner.practices.first
      pharmacy = pharmacies.sample
      drug = drugs.sample

      rx  = PrescriptionOrder.create rx_id: SecureRandom.uuid, practitioner: practitioner, patient: patient, drug: drug, pharmacy: pharmacy, practice: practice
      rx.update_attributes created_at: patient.created_at, expiration_date: (patient.created_at + 30.days)
      wrlog 'Rx '
    end
  end
end

wrlog "\n Done"
