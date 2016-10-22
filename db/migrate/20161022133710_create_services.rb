class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.belongs_to :provider, null: false

      t.text :category # shelter, food, utility, education, health
      t.text :name, null: false

      # Restrictions, X requires client to be TRUE
      # Specific to housing-type now only
      t.boolean :male, null: false, default: false
      t.boolean :female, null: false, default: false
      t.boolean :family, null: false, default: false
      t.boolean :sober, null: false, default: false
      t.boolean :ssn, null: false, default: false

      t.timestamps null: false
    end
  end
end
