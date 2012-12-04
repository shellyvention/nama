class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :event_id
	  t.integer :stars
	  t.integer :stars_max
	  t.integer :stars_extra

      t.timestamps
    end
  end
end
