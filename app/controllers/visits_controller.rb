class VisitsController < ApplicationController
  def new
    @visit = Visit.new practitioner:  @current_practitioner, organization: @current_practice, visit_start_dttm: Time.now
  end

  def create
    @visit = Visit.create visit_params
    set_visit_context @visit
    render action: :show
  end

  def show
    @visit = Visit.find params[:id]
  end

  def index
    @visits = @current_practitioner.visits
  end

  def destroy
    remove_visit_context
    redirect_to root_path
  end

  private
  def visit_params
    params.require(:visit).permit!
  end

  def remove_visit_context
    session[:visit_id] = nil
    @current_visit = nil
    @current_patient = nil
  end
end
