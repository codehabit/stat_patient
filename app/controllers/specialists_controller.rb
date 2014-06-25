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

  private

  def specialist_params
    params.require(:specialist).permit!
  end

end
