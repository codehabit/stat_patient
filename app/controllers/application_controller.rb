class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :get_context
  skip_before_action :verify_authenticity_token
  skip_before_action :get_context, if: -> {
    devise_destroy = params[:controller] == Devise::SessionsController && params[:action] == "destroy"
    devise_destroy || json_request?
  }

  # Skip if we are creating a new patient
  # skip_before_action :get_context, if: ->{request.path == patients_path}

  private

  def get_context
    return unless current_user
    set_practice_context
    # get_visit_context
  end

  def set_practice_context
    @current_practitioner = @current_user.practitioner
    @current_practice = @current_practitioner.practices.first
    Time.zone = @current_practice.time_zone if @current_practice && @current_practice.time_zone.present?
  end

  def set_visit_context visit
    session[:visit_id] = visit.id
    @current_visit = visit
    @current_patient = @current_visit.patient.decorate
  end

  def get_visit_context
    return unless session[:visit_id]
    @current_visit = Visit.where(id:  session[:visit_id]).first
    clear_visit_context if @current_visit.blank?
    @current_patient = @current_visit.patient.decorate
  end

  def clear_visit_context
    session[:visit_id] = nil
    @current_visit = nil
    @current_patiet = nil
  end

  protected

  def json_request?
    request.format.json?
  end
end
