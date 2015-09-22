class Organization < ActiveRecord::Base
  has_many :prescription_orders, foreign_key: 'pharmacy_id'
  has_many :laboratory_orders, foreign_key: 'laboratory_id'
  has_many :organization_memberships
  has_many :members, through: :organization_memberships, source: :practitioner
  # TODO - ran out of time to get the has_many :through to work in the form
  has_many :contacts, as: :contactable
  has_many :addresses, as: :addressable
  has_many :watched_cases, as: :case_watcher
  has_many :watchable_cases, through: :watched_cases
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :members

  def work_phone
    contacts.where(contact_type: 'work_phone').first.try(:info)
  end
  def email
    contacts.where(contact_type: 'email').first.try(:info)
  end
  def work_fax
    contacts.where(contact_type: 'work_fax').first.try(:info)
  end
end

