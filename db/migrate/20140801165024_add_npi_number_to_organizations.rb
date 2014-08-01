class AddNpiNumberToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :npi_identifier, :string
  end
end
