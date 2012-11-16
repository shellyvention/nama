class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :postal_code
	  t.string :city
      t.string :phone_landline
      t.string :phone_mobile
      t.date :date_of_birth
      t.string :email
	  t.string :password_digest
	  t.string :activation_token
      t.boolean :active, default: false, null: false

      t.timestamps
    end

	add_index :users, :email, unique: true
  end
end
