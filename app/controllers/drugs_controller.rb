class DrugsController < ApplicationController
  respond_to :json

  def show
    drug = Drug.find params[:id]
    render json: drug.to_json
  end
end
