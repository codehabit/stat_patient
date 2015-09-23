class LaboratoryOrderUpdater
  class << self
    def create(order)
      attachments = Attachment.where attachable_uuid: order.uuid
      order.attachments = attachments
      order.save
    end
  end
end

