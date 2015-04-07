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
    receipts.blank? || (latest_message.present? && receipts.first.created_at < latest_message.created_at)
  end
end

