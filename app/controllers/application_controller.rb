class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_context

  def get_context
    if patient_id = params[:patient] || session[:patient]
      @patient = Patient.find patient_id
    end
    @patients = Patient.all
    session[:patient] = @patient.try(:id)
    @practitioner = current_user.practitioner
    @received_cases= @practitioner.received_cases
  end
end
