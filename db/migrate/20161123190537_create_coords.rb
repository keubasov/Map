class CreateCoords < ActiveRecord::Migration
  def change
    create_table :coords do |t|
      t.text :city
      t.text :street
      t.integer :house
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps null: false
    end
  end
end
