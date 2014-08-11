class OrganizationMembership < ActiveRecord::Base
  belongs_to :practitioner
  belongs_to :organization
  belongs_to :practice, foreign_key: :organization_id
  belongs_to :laboratory, foreign_key: :organization_id
  belongs_to :pharmacy, foreign_key: :organization_id
end
