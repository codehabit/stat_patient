class ToothChartsController < ApplicationController
  def show
    tooth_chart = ToothChart.find(tooth_chart_params[:id])
    render json: tooth_chart.as_json(include: {tooth_chart_markings: {methods: :status}})
  end

  def update
    tooth_chart = ToothChart.find(tooth_chart_params[:id])
    markings_attributes = JSON.parse(tooth_chart_params["tooth_chart_markings_attributes"])
    message = Message.new({body: make_custom_message(markings_attributes), sender: current_user.practitioner})
    if tooth_chart.case
      message.recipient = tooth_chart.case.originator == message.sender ? tooth_chart.case.recipient : tooth_chart.case.originator
      message.patient = tooth_chart.case.patient
      message.case = tooth_chart.case
    end
    message.save
    tooth_chart.update_attributes(tooth_chart_markings_attributes: markings_attributes)
    render json: {message_id: message.id, new_case: tooth_chart.case.nil?}
  end

  private

  def tooth_chart_params
    params.permit!
  end

  def make_custom_message(attributes)
    teeth_ids = attributes.map{|attr| attr["tooth_id"]}
    message = teeth_ids.length == 1 ? "Tooth " : "Teeth "
    message << teeth_ids.join(",")
    message << ": "
    message << tooth_chart_params["notes"]
    message
  end

end