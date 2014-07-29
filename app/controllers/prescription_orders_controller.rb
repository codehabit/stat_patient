class PrescriptionOrdersController < ApplicationController

  def new
    @patient = Patient.find(session[:patient_id]).decorate if session[:patient_id]

    @prescription_order = PrescriptionOrder.new rx_id: SecureRandom.uuid, created_at: Date.today, refills: 0, practitioner: current_user.practitioner, patient: @patient, expiration_date: 30.days.from_now
  end

  def create
    @prescription_order = PrescriptionOrder.create(prescription_order_params)
    session[:patient_id] = @prescription_order.patient_id
    if @prescription_order.save
      redirect_to prescription_orders_path
    else
      render action: :new
    end
  end

  def show
    @prescription_order = PrescriptionOrder.find params[:id]
    @patient = @prescription_order.patient.decorate
  end

  def edit
    @prescription_order = PrescriptionOrder.find params[:id]
    @patient = @prescription_order.patient.decorate
  end

  def update
    @prescription_order = PrescriptionOrder.find params[:id]
    @prescription_order.update_attributes prescription_order_params
    redirect_to prescription_orders_path
  end

  def index
    page = params[:page] || 1
    @prescription_orders = PrescriptionOrder.where(practitioner_id: current_user.practitioner.id).order('created_at DESC').page(page)
  end

  private
  def prescription_order_params
    params.require(:prescription_order).permit!
  end
end
