class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find params[:id]
  end

  def edit
    @organization = Organization.find params[:id]
  end

  def update
    @organization = Organization.find params[:id]
  end

  def index
    @organizations = Organization.all
    @per_page = 100
  end
end

