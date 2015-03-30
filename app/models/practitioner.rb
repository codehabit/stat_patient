class Practitioner < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_many :prescription_orders

  has_many :organization_memberships
  has_many :memberships, through: :organization_memberships, source: :organization
  has_many :practices, through: :organization_memberships, source: :practice
  has_many :laboratories, through: :organization_memberships, source: :laboratory
  has_many :pharmacies, through: :organization_memberships, source: :pharmacy
  has_many :watcher_connections
  has_many :watchable_cases, through: :watcher_connections, as: :watchables, source_type: "Case"

  has_many :originations, foreign_key: :originator_id, class_name: Case
  has_many :received_cases, as: :recipient, class_name: Case
  has_many :sent_messages, foreign_key: :sender_id, class_name: Message
  has_many :received_messages, as: :recipient, class_name: Message
  has_many :contacts, as: :contactable
  has_many :addresses, as: :addressable

  has_many :visits

  def full_name
    "#{first_name} #{last_name}"
  end

  def patients
    (originations.map(&:patient) + received_cases.map(&:patient)).uniq
  end

  def involved_cases
    ids = originations.map(&:id) + received_cases.map(&:id)
    Case.where(id: ids)
  end

  def involved_cases_for patient
    ids  = patient.cases.where(recipient: self).map(&:id) +
      patient.cases.where(originator: self).map(&:id)
    Case.where(id: ids)
  end

  def practice_name
    practices.first.try(:name)
  end

  def email
    contacts.where(contact_type: 'email').first.try(:info) ||
      memberships.first.try(:email)
  end

  def work_phone
    contacts.where(contact_type: 'work_phone').first.try(:info) ||
      memberships.first.try(:work_phone)
  end
end

