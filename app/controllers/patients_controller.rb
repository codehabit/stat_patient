require 'marital_status'
require 'patient_params'

class PatientsController < ApplicationController
  def index
    page = params[:page] || 1
    @patients = @current_practitioner.practice_patients.order(:last_name).page(page)
  end

  def new
    @patient = Patient.new
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def show
    @patient = Patient.find(params[:id]).decorate
    session[:patient] = @patient.id

    respond_to do |format|
      format.html
      format.json do
        patient_attr = @patient.attributes.merge('age' => @patient.years_old)
        render json: patient_attr.to_json
      end
    end
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update_attributes(patient_params)
    redirect_to patients_path
  end

  def create
    patient_params[:practitioners] = [@current_practitioner]
    Patient.create(patient_params)
    redirect_to patients_path
  end

  def ingest
    file = params[:patients][:file]
    rows = CSV.read(file.path)
    statuses = []
    rows[1..-1].each do |row|
      p = Patient.create(
        practitioners: [@current_practitioner],
        first_name: row[0],
        last_name: row[1],
        street: row[2],
        city: row[3],
        state: row[4],
        zip_code: row[5],
        gender: row[6],
        date_of_birth: Time.strptime(row[7], "%m/%d/%y"),
        social_security_number: row[8],
        home_phone: row[9]
      )
      statuses << p.errors unless p.valid?
    end

    flash[:success] = "Successfully added #{rows.size - 1} patients" if statuses.size == 0
    flash[:warning] = "Some patients were added, but there was a problem with #{statuses.size} rows in the file. Ask the administrator what went wrong." if statuses.size > 0 && statuses.size < (rows.size - 1)
    flash[:error] = "No patients were added. Ask the administrator what went wrong." if statuses.size == (rows.size - 1)

    redirect_to patients_path
  end

  private

  def patient_params
    attrs = PatientParams.new(params).as_hash
    attrs[:practitioners] = [@current_practitioner]
    attrs.require(:patient).permit!
  end
end

