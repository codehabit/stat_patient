class RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    practitioner_attrs = params[:user].present? ? params[:user].delete(:practitioner) : {}
    self.resource.practitioner = Practitioner.create(practitioner_attrs)
  end
end

