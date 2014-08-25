class ToothChart < ActiveRecord::Base
  has_attached_file :chart, styles: {web_viewer: "466x166>"}
  do_not_validate_attachment_file_type :chart

  has_many :tooth_chart_markings, dependent: :destroy
  accepts_nested_attributes_for :tooth_chart_markings
end