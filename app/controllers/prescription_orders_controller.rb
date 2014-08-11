class PrescriptionOrdersController < ApplicationController

  def new
    @prescription_order = PrescriptionOrder.new rx_id: SecureRandom.uuid, created_at: Date.today, refills: 0, practitioner: @practitioner, practice: @current_practice, patient: @patient, expiration_date: 30.days.from_now
  end

  def create
    @prescription_order = PrescriptionOrder.create(prescription_order_params.merge(practitioner: @practitioner, practice: @current_practice))
    @prescription_order.practice = @current_practice
    set_current_patient @prescription_order.patient

    if @prescription_order.valid?
      redirect_to prescription_order_path(@prescription_order)
    else
      render action: :new
    end
  end

  def print
    @prescription_order = PrescriptionOrder.find params[:id]
    @prescription_order.update_attribute(:flow_status, 'printed') if @prescription_order.printable?
    @patient = @prescription_order.patient.decorate
    respond_to do |format|
      format.html {render layout: 'print'}
    end
  end

  def show
    @prescription_order = PrescriptionOrder.find params[:id]
    @patient = @prescription_order.patient.decorate
  end

  def submit
    if (@prescription_order = PrescriptionOrder.find params[:id]).submittable?
      @patient = @prescription_order.patient.decorate
      @prescription_order.update_attributes prescription_order_params.merge(flow_status: 'submitted')
      render
    else
      flash[:warning] = "This prescription is no longer submittable"
      redirect_to prescription_order_path(@prescription_order)
    end
  end

  def edit
    @prescription_order = PrescriptionOrder.find params[:id]
    @patient = @prescription_order.patient.decorate
    respond_to do |format|
      format.html do
        if ['printed', 'submitted'].include?(@prescription_order.flow_status)
          redirect_to prescription_order_path(@prescription_order)
        else
          render
        end
      end
    end
  end

  def update
    @prescription_order = PrescriptionOrder.find params[:id]
    @prescription_order.update_attributes prescription_order_params
    redirect_to prescription_order_path(@prescription_order)
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
