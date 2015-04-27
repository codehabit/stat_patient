class CasesController < ApplicationController
  def index
    @cases = current_user.practitioner.involved_cases.order("updated_at DESC")
  end

  def new
    @case = Case.new(patient: @current_patient, originator: @current_practitioner)
    create_tooth_chart!
    @uuid = UUID.generate
  end

  def create
    tooth_chart_id = case_params.delete :tooth_chart_id
    message_ids = case_params.delete :message_ids
    @case = Case.new(case_params)
    if @case.valid?
      CaseUpdater.originate(@case, request)
      ToothChart.find(tooth_chart_id).update_attribute(:case_id, @case.id)
      if message_ids
        message_ids.each do |message_id|
          message = Message.find message_id
          message.recipient = @case.originator == message.sender ? @case.recipient : @case.originator
          message.patient = @case.patient
          message.case = @case
          message.created_at = Time.now
          message.save
        end
      end
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
    ReadReceipt.create(read_case: @case, practitioner: @current_practitioner)
  end

  def edit
    @case = Case.find(params[:id])
  end

  def archive
    @case = Case.find(params[:case_id])
    @case.update archived: true
    message = {id: @case.id}
    render json: message.to_json
  end

  def restore
    @case = Case.find(params[:case_id])
    @case.update archived: false
    message = {id: @case.id}
    render json: message.to_json
  end

  private

  def case_params
    params.require(:case).permit!
  end

  def create_tooth_chart!
    file = File.new(Rails.root + "app/assets/images/AdultToothChart_1.jpg", "r")
    @case.tooth_chart = ToothChart.create(chart: file)
    file.close
  end
end

