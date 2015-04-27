class Case < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :visit
  has_many :case_watchers
  has_many :watching_practices, through: :case_watchers, source: :watcher, source_type: "Practice"
  has_many :read_receipts
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

  def unread?(current_practitioner)
    receipts = ReadReceipt.where(read_case: self, practitioner: current_practitioner).order("created_at DESC")
    latest_message = self.messages.order("created_at DESC").first

    no_read_receipts_and_isnt_sender = receipts.blank? && self.originator.id != current_practitioner.id
    messages_and_no_read_receipts = latest_message.present? && receipts.blank? && self.messages.count > 1
    read_receipts_but_new_message = ((latest_message.present? && self.messages.count > 1) && (receipts.present? && receipts.first.created_at < latest_message.created_at))

    no_read_receipts_and_isnt_sender || messages_and_no_read_receipts || read_receipts_but_new_message
  end
end

