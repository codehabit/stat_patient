class Practitioner < ActiveRecord::Base
  belongs_to :user, autosave: true

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many :cases, as: :recipient
end
