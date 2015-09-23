class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find params[:id]
  end

  def edit
    @organization = Organization.find params[:id]
  end

  def create
    password = params[:laboratory][:members_attributes]["0"].delete("password")
    password_confirmation = params[:laboratory][:members_attributes]["0"].delete("password_confirmation")
    organization = Organization.new
    organization.attributes = organization_params
    if organization.valid?
      practitioner = organization.members.first
      user = User.create(practitioner: practitioner, email: practitioner.email, password: password, password_confirmation: password_confirmation, first_name: practitioner.first_name, last_name: practitioner.last_name)
      organization.save
      redirect_to organizations_path
    else
      render action: :new
    end
  end

  def update
    organization = Organization.find params[:id]
    organization.update_attributes organization_params
    redirect_to organizations_path
  end

  def new
    # TODO - make this detect the type from the path
    # Right now, the only "ask" is for the ability to create a new laboratory.
    @organization = Laboratory.new
    @organization.addresses.build
    @organization.members.build
    @organization.members.first.user = User.new
  end

  def index
    # TODO - only allow management of Laboratories
    @organizations = Laboratory.all
    @per_page = 100
  end

  def destroy
    org = Organization.find(params[:id])
    org.destroy
    redirect_to organizations_path
  end

  private

  def organization_params
    org_type = nil
    [:practice, :laboratory, :pharmacy].each do |type|
      if params[type].present?
        org_type = type
        break
      end
    end


    params.require(org_type).permit!
  end
end

