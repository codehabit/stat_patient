class CorrectSpellingOfMiddleInitialForPatients < ActiveRecord::Migration
  def change
    rename_column :patients, :middile_initial, :middle_initial
  end
end
