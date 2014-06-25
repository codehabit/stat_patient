class SpecialistsController < ApplicationController

  def new
    @specialist = Specialist.new
  end

  def create
    Specialist.create specialist_params
    redirect_to specialists_path
  end

  def index
    @specialists = Specialist.all
  end

  def edit
    @specialist = Specialist.find params[:id]
  end

  def update
    specialist = Specialist.find params[:id]
    specialist.update_attributes specialist_params
    flash[:notice]  = "Successfully updated specialist #{specialist.full_name}"
    redirect_to specialists_path
  end

  private

  def specialist_params
    params.require(:specialist).permit!
  end

end
