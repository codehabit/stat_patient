class Case < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :visit
  has_many :case_watchers
  has_many :watching_practices, through: :case_watchers, source: :watcher, source_type: "Practice"
  accepts_nested_attributes_for :watching_practices
  belongs_to :originator, class_name: Practitioner
  has_many :attachments, as: :attachable
  has_many :messages
  accepts_nested_attributes_for :messages
  has_one :tooth_chart
  validates :recipient, presence: true
  validates :patient, presence: true

  def artifact_type
    "Message"
  end

  def has_attachments?
    messages.select{|message| message.attachments.present?}.length > 0
  end

  def has_unread?(current_practitioner)
    new_reply = self.new_reply? && self.messages.last.practitioner_id != current_practitioner.id
    new_reply || !self.read?
  end
end

