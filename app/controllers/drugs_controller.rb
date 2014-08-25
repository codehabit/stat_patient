class DrugsController < ApplicationController
  respond_to :json

  def show
    @drug = Drug.find params[:id]
    respond_to do |format|
      format.json {render json: @drug.to_json}
      format.html
    end
  end

  def edit
    @paths = {}
    tree = Drugs::DiagnosisDecisionTree
    DrugDiagnosisAssignment.where(drug_id: @drug.id).each do |assg|
      @paths[assg] = tree.path_for assg.diagnosis_id
    end
    @drug = Drug.find params[:id]
  end

  def update
    @drug = Drug.find params[:id]
    @drug.update_attributes drug_params
    flash[:success] = "#{@drug.selection_name} update successfully."
    redirect_to drugs_path
  end

  def index
    @per_page = 100
    @drugs = Drug.all
  end

  private

  def drug_params
    params.require(:drug).permit!
  end
end
