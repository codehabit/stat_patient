class VisitArtifactAttachment < ActiveRecord::Base
  belongs_to :visit
  belongs_to :artifact, polymorphic: true
end
