class PrescriptionOrdersController < ApplicationController

  def new
    @category = 'top'
    @choices = Drugs::DiagnosisDecisionTree.send(@category.to_sym)
    @prescription_order = PrescriptionOrder.new rx_id: SecureRandom.uuid, created_at: Date.today, refills: 0, practitioner: @current_practitioner, practice: @current_practice, patient: @current_patient, expiration_date: 30.days.from_now
  end

  def create
    @category = 'top'
    @choices = Drugs::DiagnosisDecisionTree.send(@category.to_sym)
    @prescription_order = PrescriptionOrder.create(prescription_order_params)
    @current_visit.prescription_orders << @prescription_order if @current_visit

    if @prescription_order.valid?
      redirect_to prescription_order_path(@prescription_order)
    else

      flash[:error] = @prescription_order.errors.full_messages.join(', ')
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
      if @current_visit.present?
        redirect_to visit_path(@current_visit)
      else
        redirect_to root_path
      end
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
