class AttachmentsController < ApplicationController
  respond_to :json

  def create
    if params[:file].content_type == "application/pdf"
      @created = Pdf.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    elsif MsDoc.ms_type?(params[:file].content_type)
      @created = MsDoc.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    else
      @created = Image.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    end
    message = {created_id: @created.id}
    respond_with message, location: attachment_path(@created)
  end

  def show
    @attachment = Attachment.find(params[:id])
    render layout: false
  end
end

