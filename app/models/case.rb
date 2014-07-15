class Case < ActiveRecord::Base
  belongs_to :patient
  belongs_to :recipient, polymorphic: true
  belongs_to :originator, class_name: Practitioner
  has_many :images, as: :imageable
  has_many :messages
  accepts_nested_attributes_for :messages
  has_one :tooth_chart
  validates :recipient, presence: true
  validates :patient, presence: true
  before_create :add_tooth_chart

  private

  def add_tooth_chart
    file = File.new(Rails.root + "app/assets/images/AdultToothChart_1.jpg", "r")
    self.tooth_chart = ToothChart.new(chart: file)
    file.close
  end

end

