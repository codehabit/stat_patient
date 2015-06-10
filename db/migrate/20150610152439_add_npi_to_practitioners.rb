class AddNpiToPractitioners < ActiveRecord::Migration
  def change
    add_column :practitioners, :npi, :string
  end
end
