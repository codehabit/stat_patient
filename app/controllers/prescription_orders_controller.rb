class PrescriptionOrdersController < ApplicationController

  def new
    @prescription_order = PrescriptionOrder.new rx_id: SecureRandom.uuid
  end

  def create
    @po = @prescription_order = PrescriptionOrder.create(prescription_order_params)
    if @prescription_order.save
      redirect_to prescription_orders_path
    else
      render action: :new
    end
  end

  def show
    @prescription_order = PrescriptionOrder.find params[:id]
  end

  def edit
    @prescription_order = PrescriptionOrder.find params[:id]
  end

  def index
    page = params[:page] || 1
    @prescription_orders = PrescriptionOrder.order('created_at DESC').page(page)
  end

  private
  def prescription_order_params
    params.require(:prescription_order).permit!
  end
end
