class AddActivationTokenAndActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string
    add_column :users, :active, :boolean, default: false, null: false
  end
end
