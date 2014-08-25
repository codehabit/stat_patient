class ToothChartsController < ApplicationController
  def show
    tooth_chart = ToothChart.find(tooth_chart_params[:id])
    render json: tooth_chart.as_json(include: {tooth_chart_markings: {methods: :status}})
  end

  def update
    tooth_chart = ToothChart.find(tooth_chart_params[:id])
    tooth_chart.update_attributes(tooth_chart_markings_attributes: JSON.parse(tooth_chart_params["tooth_chart_markings_attributes"]))
    head :ok
  end

  private

  def tooth_chart_params
    params.permit!
  end

end