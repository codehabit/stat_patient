class ContactPoint < ActiveRecord::Base
  belongs_to :contactalbe, polymorphic: true
end
