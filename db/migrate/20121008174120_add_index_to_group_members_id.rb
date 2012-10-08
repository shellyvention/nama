class AddIndexToGroupMembersId < ActiveRecord::Migration
	def change
		add_index :group_members, :group_id
		add_index :group_members, :user_id
	end
end
