class CasesController < ApplicationController
  def index
    @cases = Case.where(recipient: current_user.practitioner)
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)
    if @case.valid?
      @case.save
      PractitionerMailer.notification_email(@case).deliver
      redirect_to cases_path
    else
      render action: :new
    end
  end

  def show
    @case = Case.find(params[:id])
    if @case.recipient.user != current_user
      redirect_to cases_path
    end
  end

  def edit
    @case = Case.find(params[:id])
  end

  private

  def case_params
    params.require(:case).permit!
  end
end

