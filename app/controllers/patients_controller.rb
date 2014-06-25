class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    day = params[:day_of_birth]
    month = params[:month_of_birth]
    year = params[:year_of_birth]
    attributes = patient_params
    attributes[:date_of_birth] = DateTime.new(year.to_i, month.to_i, day.to_i) if day.present? && month.present? && year.present?
    Patient.create(patient_params)
    redirect_to patients_path
  end

  private

  def patient_params
    params.require(:patient).permit!
  end
end

