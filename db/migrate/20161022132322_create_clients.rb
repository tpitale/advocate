class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :phone, null: false
      t.text :first_name
      t.text :last_name
      t.text :last_address
      t.text :gender
      t.text :ssn
      t.text :ethnicity
      t.text :education

      t.boolean :employed
      t.boolean :veteran
      t.boolean :domestic_assault_victim
      t.boolean :mental_health

      t.integer :kid_count

      t.date :birthdate

      t.timestamps null: false
    end

    add_index :clients, :phone, unique: true
  end
end
