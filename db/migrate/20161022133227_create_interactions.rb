class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.belongs_to :client, null: false
      t.belongs_to :user, null: true

      t.text :status
      t.text :description

      t.timestamps null: false
    end

    add_index :interactions, :client_id
    add_index :interactions, :user_id
  end
end
