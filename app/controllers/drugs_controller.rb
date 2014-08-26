class DrugsController < ApplicationController
  respond_to :json

  def new
    @drug = Drug.new uuid: SecureRandom.uuid
  end

  def show
    @drug = Drug.find_by uuid: params[:id]
    respond_to do |format|
      format.json {render json: @drug.to_json}
      format.html
    end
  end

  def edit
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
