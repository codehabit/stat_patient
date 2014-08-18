class CasesController < ApplicationController
  def index
    @cases = current_user.practitioner.involved_cases.order("updated_at DESC")
  end

  def new
    @case = Case.new(patient: @current_patient, originator: @current_practitioner)
    @uuid = UUID.generate
  end

  def create
    @case = Case.new(case_params)
    if @case.valid?
      CaseUpdater.originate(@case, request)
      if @current_visit.present?
        @current_visit.cases << @case
        redirect_to visit_path(@current_visit)
      else
        redirect_to root_path
      end
    else
      render action: :new
    end
  end

  def star
    @case = Case.find(params[:case_id])
    @case.starred = !(@case.starred)
    @case.save
    result = {starred: @case.starred}
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def add_participant
    @case = Case.find(params[:case_id])
    @case.attributes = case_params
    added_id = params[:case][:watching_practice_ids]
    if @case.valid?
      CaseUpdater.on_participant_added(@case, request, added_id)
      redirect_to case_path(@case)
    else
      render action: :show
    end
  end

  def reply
    @case = Case.find(params[:case_id])
    @case.attributes = case_params
    if @case.valid?
      CaseUpdater.reply(@case, request)
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

