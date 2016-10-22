class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.text :name, null: false
      t.text :address
      t.text :city
      t.text :state
      t.text :zip
      t.text :phone
      t.text :website

      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
