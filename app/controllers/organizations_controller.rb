class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find params[:id]
  end

  def edit
    @organization = Organization.find params[:id]
  end

  def create
    organization = Organization.new
    organization.attributes = organization_params
    if organization.valid?
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
  end

  def index
    @organizations = Organization.all
    @per_page = 100
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

