class AnnotationsController < ApplicationController
  before_filter :get_attachment

  def index
    render json: @attachment.annotations.to_json
  end

  def create
    annotation = @attachment.annotations.create(annotation_params)
    render json: {id: annotation.id}
  end

  def update
    annotation = @attachment.annotations.find(params[:id])
    annotation.update_attributes(annotation_params)
    render json: {id: annotation.id}
  end

  def destroy
    annotation = @attachment.annotations.find(params[:id])
    annotation.destroy!
    head :ok
  end

  private

  def attachment_params
    params.permit!
  end

  def annotation_params
    annotation_params = attachment_params[:annotation]
    annotation_params.delete("id")
    annotation_params
  end

  def get_attachment
    @attachment = Attachment.find(attachment_params[:attachment_id])
  end
end