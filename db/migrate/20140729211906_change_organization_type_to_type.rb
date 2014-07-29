class ChangeOrganizationTypeToType < ActiveRecord::Migration
  def change
    rename_column :organizations, :organization_type, :type
  end
end
