class OrganizationMembership < ActiveRecord::Base
  belongs_to :practitioner
  belongs_to :organization
end
