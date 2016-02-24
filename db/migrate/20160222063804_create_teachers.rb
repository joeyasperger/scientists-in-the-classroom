class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :email
      t.string :phone
      t.string :school
      t.string :communication_method
      t.string :grade
      t.string :topics
      t.string :class_times
      t.boolean :climate_change
      t.boolean :evolution
      t.string :topics_to_cover
      t.string :benefits
      t.string :requirements
      t.boolean :read_expectations
      t.boolean :approved
      t.timestamps null: false
    end
  end
end
