class AddDeaNumberToPractitioners < ActiveRecord::Migration
  def change
    add_column :practitioners, :dea_identifier, :string
  end
end
