class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_context

  def get_context
    @collapsed = params[:collapsed] || session[:collapsed]
    if patient_id = params[:patient] || session[:patient]
      @patient = Patient.find patient_id
    end
    @patients = Patient.all
    session[:collapsed] = @collapsed
    session[:patient] = @patient.try(:id)
    @practitioner = current_user.try(:practitioner)
    @received_cases= @practitioner.try(:received_cases)
  end
end
