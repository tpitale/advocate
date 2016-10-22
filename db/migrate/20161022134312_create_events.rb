class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :interaction, null: false
      t.belongs_to :user, null: true

      t.text :source_type # sms, phone, inperson
      t.text :content # our note, or the sms message

      t.timestamps null: false
    end

    add_index :events, :interaction_id
    add_index :events, :user_id
  end
end
