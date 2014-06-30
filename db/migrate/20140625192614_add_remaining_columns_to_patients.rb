class AddRemainingColumnsToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :title, :string
    add_column :patients, :street, :string
    add_column :patients, :street2, :string
    add_column :patients, :city, :string
    add_column :patients, :state, :string
    add_column :patients, :zip_code, :string
    add_column :patients, :home_phone, :string
    add_column :patients, :mobile_phone, :string
    add_column :patients, :work_phone, :string
    add_column :patients, :email, :string
    add_column :patients, :gender, :string
    add_column :patients, :marital_status, :string
    add_column :patients, :social_security_number, :string
  end
end
