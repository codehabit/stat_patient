class Visit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :practitioner
  belongs_to :organization

  #ugh
  has_many :visit_artifact_attachments
  has_many :cases, through: :visit_artifact_attachments, source: :artifact, source_type: 'Case'
  has_many :prescription_orders, through: :visit_artifact_attachments, source: :artifact, source_type: 'PrescriptionOrder'
  has_many :laboratory_orders, through: :visit_artifact_attachments, source: :artifact, source_type: 'LaboratoryOrder'

  def artifacts
    visit_artifact_attachments.map do |attachment|
      attachment.artifact
    end
  end
end
