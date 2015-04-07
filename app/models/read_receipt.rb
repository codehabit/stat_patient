class ReadReceipt < ActiveRecord::Base
  belongs_to :practitioner
  belongs_to :read_case, class: Case
end

