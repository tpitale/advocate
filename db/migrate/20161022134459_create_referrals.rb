class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.belongs_to :interaction, null: false
      t.belongs_to :service, null: false

      t.text :code, null: false

      t.text :status # open, confirmed
      t.text :note # added by provider

      t.timestamps null: false
    end

    add_index :referrals, :interaction_id
    add_index :referrals, :service_id
    add_index :referrals, :code, unique: true
  end
end
