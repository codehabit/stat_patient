class ToothChartMarking < ActiveRecord::Base
  belongs_to :tooth_chart

  STATUS_CODES = {
    1 => "extracted",
    2 => "missing",
    3 => "observation"
  }

  def status
    STATUS_CODES[self.status_code]
  end
end