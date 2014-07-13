class ImagesController < ApplicationController
  def create
    Image.create(asset: params[:file], imageable_uuid: params[:images][:message_uuid])
    render nothing: true
  end
end

