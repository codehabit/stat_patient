# Copyright © 2014 Stat Patient, Inc. All Rights Reserved
class LabItem < ActiveRecord::Base
  belongs_to :laboratory_order
end

