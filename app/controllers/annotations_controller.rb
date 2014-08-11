class AnnotationsController < ApplicationController
  before_filter :get_tooth_chart

  def index
    render json: @tooth_chart.annotations.to_json
  end

  def create
    annotation = @tooth_chart.annotations.create(annotation_params)
    render json: {id: annotation.id}
  end

  def update
    annotation = @tooth_chart.annotations.find(params[:id])
    annotation.update_attributes(annotation_params)
    render json: {id: annotation.id}
  end

  def destroy
    annotation = @tooth_chart.annotations.find(params[:id])
    annotation.destroy!
    head :ok
  end

  private

  def tooth_chart_params
    params.permit!
  end

  def annotation_params
    annotation_params = tooth_chart_params[:annotation]
    annotation_params.delete("id")
    annotation_params
  end

  def get_tooth_chart
    @tooth_chart = ToothChart.find(tooth_chart_params[:tooth_chart_id])
  end
end