class AddNpiNumberToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :national_provider_identifier, :string
  end
end
