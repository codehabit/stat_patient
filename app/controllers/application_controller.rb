class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_context

  def get_context
    return unless current_user

    @practitioner = current_user.practitioner
    @patients = @practitioner.patients
    patient_param = params['patient']

    if patient_param == ""
      # patient intentionally removed, show all things
      session[:patient] = nil
      @patient_cases = @practitioner.involved_cases

    elsif patient_id = (patient_param || session[:patient])
      @patient = Patient.find patient_id
      session[:patient] = @patient.id
      @patient_cases = @practitioner.involved_cases_for @patient
    else
      # nothing present (like at sign in)
      @patient_cases = @practitioner.involved_cases
    end

    @collapsed = params[:collapsed] || session[:collapsed]
    session[:collapsed] = @collapsed
  end
end

