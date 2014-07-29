class AddStiToImages < ActiveRecord::Migration
  def change
    add_column :images, :type, :string
  end
end

