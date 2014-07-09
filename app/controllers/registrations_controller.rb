class RegistrationsController < Devise::RegistrationsController
  def new
    @practitioner = Practitioner.new
    super
  end

  protected

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    practitioner_attrs = params[:user].present? ? params[:user].delete(:practitioner) : {}
    self.resource.practitioner = Practitioner.new(practitioner_attrs)
  end
end

