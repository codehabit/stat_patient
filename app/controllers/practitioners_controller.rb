class PractitionersController < ApplicationController

  def new
    @practitioner = Practitioner.new
    @practitioner.practices.build
    @practitioner.practices.first.addresses.build
    @practitioner.contacts.build(contact_type: "email")
    @practitioner.contacts.build(contact_type: "work_phone")
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
    @practitioner.contacts.build(contact_type: "email") if @practitioner.contacts.where(contact_type: "email").empty?
    @practitioner.contacts.build(contact_type: "work_phone") if @practitioner.contacts.where(contact_type: "work_phone").empty?
    if @practitioner.practices.empty?
      @practitioner.practices.build
      @practitioner.practices.first.addresses.build
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
