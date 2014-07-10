class ChangeSpecialistToPractitioner < ActiveRecord::Migration
  def change
    rename_table :specialists, :practitioners
  end
end
