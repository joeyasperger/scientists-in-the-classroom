class AddZipCode < ActiveRecord::Migration
  def change
    add_column :teachers, :zip_code, :string
    add_column :teachers, :lat, :decimal
    add_column :teachers, :lng, :decimal
    add_column :scientists, :zip_code, :string
    add_column :scientists, :lat, :decimal
    add_column :scientists, :lng, :decimal
  end
end
