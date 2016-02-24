class CreateScientists < ActiveRecord::Migration
  def change
    create_table :scientists do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :email
      t.string :phone
      t.string :communication_method
      t.string :occupation
      t.string :education
      t.string :affiliation
      t.boolean :evolution
      t.boolean :climate_change
      t.string :specialization
      t.string :experience
      t.string :goals
      t.string :availability
      t.boolean :committed
      t.boolean :less_than_30
      t.string :link
      t.boolean :read_expectations
      t.timestamps null: false
    end
  end
end
