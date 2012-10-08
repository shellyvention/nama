class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :group_id,		default: 0,		null: false
      t.integer :user_id,		default: 0,		null: false

      t.timestamps
    end
  end
end
