class AttachmentsController < ApplicationController
  def create
    if params[:file].content_type == "application/pdf"
      Pdf.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    elsif MsDoc.ms_type?(params[:file].content_type)
      MsDoc.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    else
      Image.create(asset: params[:file], attachable_uuid: params[:attachments][:message_uuid])
    end
    render nothing: true
  end
end

