require 'marital_status'
require 'patient_params'

class PatientsController < ApplicationController
  def index
    page = params[:page] || 1
    @patients = Patient.order(:last_name).page(page)
  end

  def new
    @patient = Patient.new
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update_attributes(patient_params)
    redirect_to patients_path
  end

  def create
    Patient.create(patient_params)
    redirect_to patients_path
  end

  private

  def patient_params
    attrs = PatientParams.new(params).as_hash
    attrs.require(:patient).permit!
  end
end

