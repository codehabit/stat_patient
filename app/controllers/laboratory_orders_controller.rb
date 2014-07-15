class LaboratoryOrdersController < ApplicationController
  def new
    @laboratory_order = LaboratoryOrder.new
  end
end

