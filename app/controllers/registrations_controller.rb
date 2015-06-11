class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    if params[:user].present?
      practitioner_attrs = params[:user].delete(:practitioner)
      email = params[:user][:email]
      p = Practitioner.new(practitioner_attrs)
      p.contacts << Contact.new(contact_type: "email", info: email)
      p.save
      self.resource.practitioner = p
    else
      self.resource.practitioner = Practitioner.new
    end
  end
end

