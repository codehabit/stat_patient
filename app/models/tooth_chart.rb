class ToothChart < ActiveRecord::Base
  has_many :annotations, dependent: :destroy
  has_attached_file :chart, styles: {web_viewer: "466x166>"}
  do_not_validate_attachment_file_type :chart
end