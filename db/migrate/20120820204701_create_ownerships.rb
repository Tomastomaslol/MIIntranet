class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
