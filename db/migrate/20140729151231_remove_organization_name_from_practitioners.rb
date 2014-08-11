class RemoveOrganizationNameFromPractitioners < ActiveRecord::Migration
  def up
    remove_column :practitioners, :practice_name
    remove_column :practitioners, :email
    remove_column :practitioners, :phone
    add_column    :practitioners, :title, :string
    add_column    :practitioners, :salutation, :string
    add_column    :practitioners, :suffix, :string
  end

  def down
    add_column :practitioners, :practice_name, :string
    add_column :practitioners, :email, :string
    add_column :practitioners, :phone, :string
    remove_column :practitioners, :title
    remove_column :practitioners, :salutation
    remove_column :practitioners, :suffix
  end
end
