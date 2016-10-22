class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.belongs_to :user, null: false
      t.belongs_to :provider, null: true

      t.text :role_type # volunteer, manager

      t.timestamps null: false
    end

    add_index :roles, :user_id
    add_index :roles, :provider_id
  end
end
