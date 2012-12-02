class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.time :from
      t.time :to
      t.integer :event_id, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
