class LaboratoryOrdersController < ApplicationController
  def new
    @laboratory_order = LaboratoryOrder.new due_date: 5.days.from_now, patient: @current_patient, practitioner: @current_practitioner
  end

  def create
    @laboratory_order = LaboratoryOrder.create laboratory_order_params
    @current_visit.laboratory_orders << @laboratory_order if @current_visit
    if @laboratory_order.valid?
      redirect_to visit_path(@current_visit)
    else
      flash[:error] = @laboratory_order.errors.full_messages.join(', ')
      render action: :new
    end

  end
  private
  def laboratory_order_params
    params.require(:laboratory_order).permit!
  end
end

