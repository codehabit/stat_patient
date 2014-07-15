class Practitioner < ActiveRecord::Base
  belongs_to :user, autosave: true
  has_many :prescription_orders

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many :originations, foreign_key: :originator_id, class_name: Case
  has_many :received_cases, as: :recipient, class_name: Case
  has_many :sent_messages, foreign_key: :sender_id, class_name: Message
  has_many :received_messages, as: :recipient, class_name: Message

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
end

