class AddAuthTokenToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :auth_token, :string
  end
end
