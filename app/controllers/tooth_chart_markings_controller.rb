class ToothChartMarkingsController < ApplicationController
  before_filter :get_tooth_chart

  def index
    render json: @tooth_chart.tooth_chart_markings.as_json(methods: :status)
  end

  def create
    tooth_chart_marking = @tooth_chart.tooth_chart_markings.create(tooth_chart_marking_params)
    render json: {id: tooth_chart_marking.id}
  end

  def update
    tooth_chart_marking = @tooth_chart.tooth_chart_markings.find(params[:id])
    tooth_chart_marking.update_attributes(tooth_chart_marking_params)
    render json: {id: tooth_chart_marking.id}
  end

  def destroy
    tooth_chart_marking = @tooth_chart.tooth_chart_markings.find(params[:id])
    tooth_chart_marking.destroy!
    head :ok
  end

  private

  def tooth_chart_params
    params.permit!
  end

  def tooth_chart_marking_params
    tooth_chart_marking_params = tooth_chart_params[:tooth_chart_marking]
    tooth_chart_marking_params.delete("id")
    tooth_chart_marking_params
  end

  def get_tooth_chart
    @tooth_chart = ToothChart.find tooth_chart_params[:tooth_chart_id]
  end
end