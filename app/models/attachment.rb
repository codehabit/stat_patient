class Attachment < ActiveRecord::Base
  has_many :annotations, dependent: :destroy
  belongs_to :attachable, polymorphic: true
end

