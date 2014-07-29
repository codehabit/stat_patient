class CasesController < ApplicationController
  def index
    @cases = current_user.practitioner.involved_cases.order("updated_at DESC")
  end

  def new
    @case = Case.new
    @uuid = UUID.generate
  end

  def create
    @case = Case.new(case_params)
    if @case.valid?
      CaseBuilder.originate(@case, request)
      redirect_to cases_path
    else
      render action: :new
    end
  end

  def update
    @case = Case.find(params[:id])
    @case.attributes = case_params
    if @case.valid?
      CaseBuilder.reply(@case, request)
      redirect_to case_path(@case)
    else
      render action: :show
    end
  end

  def show
    @uuid = UUID.generate
    @case = Case.find(params[:id])
    if @case.recipient.user != current_user && @case.originator.user != current_user
      redirect_to root_path
    end
    @case.update(read: true)
  end

  def edit
    @case = Case.find(params[:id])
  end

  private

  def case_params
    params.require(:case).permit!
  end
end

