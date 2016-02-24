class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :scientist_id
      t.integer :teacher_id
      t.timestamps null: false
    end

    add_index :matches, :scientist_id
    add_index :matches, :teacher_id
    
  end
end
