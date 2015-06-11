class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    if params[:user].present?
      practitioner_attrs = params[:user].delete(:practitioner)
      practitioner_attrs[:email] = params[:user][:email]
      self.resource.practitioner = Practitioner.create(practitioner_attrs)
    else
      self.resource.practitioner = Practitioner.new
    end
  end
end

