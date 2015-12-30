class LaboratoryOrdersController < ApplicationController
  def new
    @laboratory_order = LaboratoryOrder.new due_date: 5.days.from_now, patient: @current_patient, originator: @current_practitioner
    @uuid = UUID.generate
  end

  def create
    lab_item = LabItem.new(laboratory_order_params.delete(:lab_item))
    laboratory_order_params[:lab_item] = lab_item
    @laboratory_order = LaboratoryOrder.new laboratory_order_params
    @current_visit.laboratory_orders << @laboratory_order if @current_visit
    if @laboratory_order.valid?
      LaboratoryOrderUpdater.create(@laboratory_order)
      redirect_to @laboratory_order
    else
      flash[:error] = @laboratory_order.errors.full_messages.join(', ')
      render action: :new
    end
  end

  def submit
    laboratory_order = LaboratoryOrder.find params[:id]
    LabOrderSubmitter.submit(laboratory_order, request)
    redirect_to laboratory_order
  end

  def print
    @laboratory_order = LaboratoryOrder.find params[:id]
    render layout: 'print'
  end

  # This is for after printing or submitting
      # if @current_visit
      #   redirect_to visit_path(@current_visit)
      # else
      #   redirect_to root_path
      # end

  def show
    @laboratory_order = LaboratoryOrder.find params[:id]
  end

  def index
    page = params[:page] || 1
    @closed_orders = LaboratoryOrder.where(closed: true, originator_id: current_user.practitioner.id).order('created_at DESC').page(page)
    @active_orders = LaboratoryOrder.where("closed is null OR closed is false").where(originator_id: current_user.practitioner.id).order('created_at DESC').page(page)
    @all_orders = LaboratoryOrder.where(originator_id: current_user.practitioner.id).order('created_at DESC').page(page)
  end

  private

  def laboratory_order_params
    params.require(:laboratory_order).permit!
  end
end

