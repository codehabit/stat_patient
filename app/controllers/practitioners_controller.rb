class PractitionersController < ApplicationController

  def new
    @practitioner = Practitioner.new
    @practitioner.practices.build
    @practitioner.practices.first.addresses.build
    @practitioner.practices.first.contacts.build(contact_type: "work_phone")
  end

  def create
    Practitioner.create practitioner_params
    redirect_to practitioners_path
  end

  def index
    page = params[:page] || 1
    @practitioners = Practitioner.order(:last_name).page(page)
  end

  def show
    @practitioner = Practitioner.find params[:id]
  end

  def edit
    @practitioner = Practitioner.find params[:id]
    if @practitioner.practices.empty?
      @practitioner.practices.build
      @practitioner.practices.first.addresses.build
      @practitioner.practices.first.contacts.build(contact_type: "work_phone")
    end
  end

  def update
    practitioner = Practitioner.find params[:id]
    practitioner.update_attributes practitioner_params
    flash[:notice]  = "Successfully updated practitioner #{practitioner.decorate.full_name}"
    redirect_to practitioners_path
  end

  private

  def practitioner_params
    params.require(:practitioner).permit!
  end

end
