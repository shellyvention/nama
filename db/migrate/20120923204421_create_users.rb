class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :postal_code
      t.string :phone_landline
      t.string :phone_mobile
      t.date :date_of_birth
      t.string :email

      t.timestamps
    end
  end
end
