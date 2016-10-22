class CreateClientLocations < ActiveRecord::Migration
  def change
    create_table :client_locations do |t|
      t.belongs_to :client

      t.text :address
      t.text :city
      t.text :state
      t.text :zip

      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end

    add_index :client_locations, :client_id
  end
end
