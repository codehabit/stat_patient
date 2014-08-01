class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_context

  # Skip if we are creating a new patient
  skip_before_action :get_context, if: ->{request.path == patients_path}

  private

  def get_context
    return unless current_user

    @practitioner = current_user.practitioner
    # TODO: allow choosing the practice from your memberships
    last_current_practice = Practice.where(id: session[:current_practice_id]).first
    @current_practice = last_current_practice || @practitioner.practices.first
    @patients = @practitioner.patients

    patient_param = params['patient_id']

    if patient_param == ""
      # patient intentionally removed, show all things
      session[:patient] = nil
    elsif patient_id = (patient_param || session[:patient])
      # allow for patient.id changing when data is reloaded
      @patient = Patient.where(id: patient_id ).first
      if @patient
        session[:patient] = @patient.id
      else
        session[:patient] = nil
      end
    end

  end

  def set_current_patient patient
    session[:patient] = patient.try :id
  end


end

