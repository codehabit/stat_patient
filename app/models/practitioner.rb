class Practitioner < ActiveRecord::Base
  belongs_to :user, autosave: true

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many :originations, foreign_key: :originator_id, class_name: Case
  has_many :received_cases, as: :recipient, class_name: Case
  has_many :sent_messages, foreign_key: :sender_id, class_name: Message
  has_many :received_messages, as: :recipient, class_name: Message
end
