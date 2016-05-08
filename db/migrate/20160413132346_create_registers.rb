class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.timestamps null: false
    end
  end
end
